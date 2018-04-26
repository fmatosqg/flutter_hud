import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';

class IpAddress {
  static const platform = const MethodChannel('samples.flutter.io/ip_address');

  Future<String> getIp() async {
//    return platform.invokeMethod('ip_address'); //as Future<String>;
    return await platform.invokeMethod('mobile_address') as String;
  }
}
