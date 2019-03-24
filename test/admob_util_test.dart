import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admob_util/admob_util.dart';

void main() {
  const MethodChannel channel = MethodChannel('admob_util');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AdmobUtil.platformVersion, '42');
  });
}
