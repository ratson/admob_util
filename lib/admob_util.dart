import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class BannerSize {
  const BannerSize({
    @required this.width,
    @required this.height,
  });

  final int height;
  final int width;
}

class AdmobUtil {
  static const MethodChannel _channel =
      const MethodChannel('admob_util');

  static Future<bool> get isTestDevice async {
    try {
      return await _channel.invokeMethod('isTestDevice');
    } on PlatformException {}
    return false;
  }

  static Future<Size> getSmartBannerSize() async {
    try {
      List<double> adSize = await _channel.invokeMethod('getSmartBannerSize');
      return Size(adSize[0], adSize[1]);
    } on PlatformException {
    }
    return Size(0, 0);
  }
}
