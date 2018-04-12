import 'package:flutter_hud/domain/wifi/WifiManager.dart';

class ObjectFactory {
  static final ObjectFactory instance = ObjectFactory._internal();

  ObjectFactory._internal();

  final WifiManager _wifiManager = WifiManager();

  WifiManager getWifiManager() {
    return _wifiManager;
  }
}
