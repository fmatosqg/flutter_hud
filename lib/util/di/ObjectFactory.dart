class ObjectFactory {
  static final ObjectFactory instance = ObjectFactory._internal();

  ObjectFactory._internal();

  final WifiManager _wifiManager = WifiManager();

  WifiManager getWifiManager() {
    return _wifiManager;
  }
}

class WifiManager {
  String ip = "1.2.3.4";
}
