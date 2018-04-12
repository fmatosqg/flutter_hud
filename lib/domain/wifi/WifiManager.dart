import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class WifiManager {
  String ip = "1.2.3.4";

  Future<String> getIp() async {
    return NetworkInterface.listSupported.toString();
  }
}
