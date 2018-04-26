import 'package:flutter_hud/domain/wifi/BluetoothManager.dart';
import 'package:flutter_hud/domain/wifi/WifiManager.dart';

class ObjectFactory {
  static final ObjectFactory instance = new ObjectFactory._internal();

  ObjectFactory._internal();

  final WifiManager _wifiManager = new WifiManager();
  final BluetoothManager _bluetoothManager = new BluetoothManager();

  WifiManager getWifiManager() {
    return _wifiManager;
  }

  BluetoothManager getBluetoothManager() {
    return _bluetoothManager;
  }
}
