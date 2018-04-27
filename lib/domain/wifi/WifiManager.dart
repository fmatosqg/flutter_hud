import 'dart:async';
import 'dart:io';

class WifiManager {
  String ip = '1.2.3.4';

  Future<String> getIp() async {
    return NetworkInterface.listSupported.toString();
  }
}
