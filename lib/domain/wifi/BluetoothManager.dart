import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:simple_permissions/simple_permissions.dart';

class BluetoothManager {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  String _advertiseStatus = 'Unknown';

  Timer _advertiseTime;

  Timer _scanTimer;
  String _scanStatus = 'Nothing';

  String _statusStatus = '-';
  String _connectionStatus = '-';

  void startAdvertising() async {
    try {
      if (await _flutterBlue.startAdvertising()) {
        _advertiseStatus = 'Advertising starting';
        print('Advertising starting');

        _advertiseTime?.cancel();
        _advertiseTime = new Timer(new Duration(seconds: 180), () {
          _advertiseStatus = 'Advertise timer expired';
          print('Advertise timer expired.');
          startAdvertising();
        });
      } else {
        _advertiseStatus = 'Advertising failed to starttt';
      }
    } catch (e) {
      _advertiseStatus = 'Error ${e.toString()}';
    }
  }

  String status() {
    return 'advertise $_advertiseStatus\nscan $_scanStatus\nstatus $_statusStatus\nconnection $_connectionStatus';
  }

  void scan() async {
    _scanStatus = 'scan start';
    _connectionStatus = '--';

    final bool isOn = await _flutterBlue.isOn();
    if (!isOn) {
      _scanStatus = 'BT was off, turn on';
      await _flutterBlue.turnOn();
    }
    final List<String> deviceNameList = <String>['RPI3'];

    final bool hasPermission = await SimplePermissions
        .requestPermission(Permission.AccessCoarseLocation);

    if (hasPermission) {
      _scanTimer?.cancel();

      _statusStatus = _devices.toString();

      int deviceCount = 0;
      final StreamSubscription<ScanResult> scanSubscription =
          _flutterBlue.scan() // SCAN
              .listen((ScanResult scanResult) {
        deviceCount++;

        if (deviceNameList.contains(scanResult.device.name)) {
          print('scanResult.device[$deviceCount] = ${scanResult.device.name}');
//          try {
          _talkToDevice(scanResult);
//          } catch (e) {
//            print('I caught something $e -- ${e.runtimeType}');
//          }
        } else if (deviceCount % 10 == 0) {
          print('Found $deviceCount devices so far');
        }

        _scanStatus = 'scan listen $scanResult';

        true;
      });

      _scanTimer = new Timer(new Duration(seconds: 20), () {
        print('Cancel scan for BT devices');
        _scanStatus = 'cancel scan';
        scanSubscription.cancel();
      });
    } else {
      _scanStatus = 'no permission';
    }
  }

  final Map<String, bool> _devices =
      <String, bool>{}; // device name, connect is in progress

  void _talkToDevice(ScanResult scanResult) {
    scanResult.device.state.then((BluetoothDeviceState value) {
      print('+++device ${scanResult.device.name}  state $value');

      if (value == BluetoothDeviceState.disconnected) {
        print('+++device state decides to connect');
        _connectToDevice(scanResult);
      } else {
        print('+++device state does not decide to connect');
      }

      _statusStatus = '$value ';
    });

//    scanResult.device.con

//    List<BluetoothService> listServices =
//        await scanResult.device.discoverServices();
//
//    listServices.forEach((BluetoothService service) {
//
//      print('Service ${service.isPrimary} -- ${service.uuid}');
//
//    });

//    return true;
  }

  void _connectToDevice(ScanResult scanResult) {
    final bool isInProgress = _devices.containsKey(scanResult.device.name) &&
        _devices[scanResult.device.name];

    if (!isInProgress) {
      _devices.putIfAbsent(scanResult.device.name, () => true);
      print('+++++Added device ${scanResult.device.name}');
    } else {
      print('+++++Found device ${scanResult.device.name}');
    }
    _statusStatus = _devices.toString();

    _connectionStatus = 'about to connect';
    final StreamSubscription<BluetoothDeviceState> connection = _flutterBlue
        .connect(scanResult.device)
        .listen((BluetoothDeviceState deviceState) {
      _connectionStatus = 'connect listening to $deviceState';
      print(
          '++++Device ${scanResult.device.name} state changed to $deviceState');

      _discoverServices(scanResult.device);
    });

    new Timer(new Duration(seconds: 20), () {
      _connectionStatus = 'Disconenect timeout';
      connection.cancel();
    });
  }

  void _discoverServices(BluetoothDevice device) {
    print('++++++ Discover services now');
    device.discoverServices().then((List<BluetoothService> serviceList) {

      print('+++ List all services $serviceList');
    });
  }
}
