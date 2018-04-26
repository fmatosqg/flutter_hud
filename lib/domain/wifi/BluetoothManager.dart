import 'package:flutter_blue/flutter_blue.dart';
import 'package:simple_permissions/simple_permissions.dart';

class BluetoothManager {
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  String _status = "Unknown";

  void startAdvertising() async {
    try {
      if (await _flutterBlue.startAdvertising()) {
        _status = "Advertising starting";
      } else {
        _status = "Advertising failed to starttt";
      }
    } catch (e) {
      _status = 'Error ${e.toString()}';
    }
  }

  String status() {
    return _status;
  }
}
