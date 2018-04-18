import 'package:flutter_hud/domain/wifi/BluetoothManager.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';

class ObjectFactory {
  static final ObjectFactory instance = ObjectFactory._internal();

  ObjectFactory._internal();

  final WifiManager _wifiManager = WifiManager();
  final BluetoothManager _bluetoothManager = BluetoothManager();

  WifiManager getWifiManager() {
    return _wifiManager;
  }

  BluetoothManager getBluetoothManager() {
    return _bluetoothManager;
  }
}
