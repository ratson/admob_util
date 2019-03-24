import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:admob_util/admob_util.dart';

void main() {
  const MethodChannel channel = MethodChannel('admob_util');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('isTestDevice', () async {
    expect(await AdmobUtil.isTestDevice, true);
  });
}
