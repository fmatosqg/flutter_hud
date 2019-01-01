import 'package:flutter_hud/domain/wifi/WifiManager.dart';

class ObjectFactory {
  final WifiManager _wifiManager = WifiManager();

  WifiManager getWifiManager() {
    return _wifiManager;
  }
}
