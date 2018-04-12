import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class IpAddress {
  static const platform = const MethodChannel('samples.flutter.io/ip_address');

  Future getIp() {
//    return platform.invokeMethod('ip_address'); //as Future<String>;
    return platform.invokeMethod('mobile_address');
  }
}
