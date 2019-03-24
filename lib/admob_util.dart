import 'dart:async';

import 'package:flutter/services.dart';

class AdmobUtil {
  static const MethodChannel _channel =
      const MethodChannel('admob_util');

  static Future<bool> get isTestDevice async {
    try {
      return await _channel.invokeMethod('isTestDevice');
    } on PlatformException {}
    return false;
  }
}
