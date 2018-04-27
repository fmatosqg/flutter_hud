import 'dart:async';

import 'package:flutter/services.dart';

class IpAddress {
  static const MethodChannel platform =
      const MethodChannel('samples.flutter.io/ip_address');

  Future<String> getIp() async {
    final String ip = await platform.invokeMethod('mobile_address');
    return ip;
  }
}
