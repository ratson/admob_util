import 'dart:async';

import 'package:flutter/services.dart';

class AdmobUtil {
  static const MethodChannel _channel =
      const MethodChannel('admob_util');

  static Future<bool> get isTestDevice async {
    final bool isTestDevice = await _channel.invokeMethod('isTestDevice');
    return isTestDevice;
  }
}
