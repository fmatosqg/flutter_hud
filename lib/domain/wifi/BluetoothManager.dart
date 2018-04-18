import 'package:flutter_blue/flutter_blue.dart';
import 'package:simple_permissions/simple_permissions.dart';

class BluetoothManager {
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  String _status = "Unknown";


  void startAdvertising() {
    _flutterBlue.startAdvertising();
    _status = "Advertising activated";
  }

  String status(){

    return _status;
  }
}
