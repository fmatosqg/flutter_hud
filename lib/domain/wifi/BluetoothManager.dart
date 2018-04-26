import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:simple_permissions/simple_permissions.dart';

class BluetoothManager {
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  String _advertiseStatus = "Unknown";

  Timer _advertiseTime;

  Timer _scanTimer;
  String _scanStatus = 'Nothing';

  void startAdvertising() async {
    try {
      if (await _flutterBlue.startAdvertising()) {
        _advertiseStatus = "Advertising starting";

        _advertiseTime?.cancel();
        _advertiseTime = new Timer(new Duration(seconds: 180), () {
          _advertiseStatus = "Advertise timer expired";
        });
      } else {
        _advertiseStatus = "Advertising failed to starttt";
      }
    } catch (e) {
      _advertiseStatus = 'Error ${e.toString()}';
    }
  }

  String status() {
    return "advertise $_advertiseStatus  -- scan $_scanStatus";
  }

  void scan() async {
    _scanStatus = "scan start";

    final List<String> deviceNameList = ['RPI3'];

    bool hasPermission = await SimplePermissions
        .requestPermission(Permission.AccessCoarseLocation);

    if (hasPermission) {
      _scanTimer?.cancel();

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
        _scanStatus = "cancel scan";
        scanSubscription.cancel();
      });
    } else {
      _scanStatus = 'no permission';
    }
  }

  Map<String, bool> _devices = {}; // device name, connect is in progress

  void _talkToDevice(ScanResult scanResult) {
//    scanResult.device.state
//    var state = await

    scanResult.device.state.then((value) {
      print('device ${scanResult.device.name}  state ${value}');
    });

    bool isInProgress = _devices.containsKey(scanResult.device.name) &&
        _devices[scanResult.device.name];

    if (!isInProgress) {
      _devices.putIfAbsent(scanResult.device.name, () => true);
      print('Added device ${scanResult.device.name}');
    } else {
      print('Found device ${scanResult.device.name}');
    }

//    _devices.putIfAbsent(key, ifAbsent)

    _flutterBlue
        .connect(scanResult.device)
        .listen((dynamic deviceState) {
      print('Device ${scanResult.device.name} state changed to ${deviceState}');
    }).onError(() {
      print('Found error on BT connect');
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
}
