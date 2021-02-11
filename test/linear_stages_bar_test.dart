import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linear_stages_bar/linear_stages_bar.dart';

void main() {
  const MethodChannel channel = MethodChannel('linear_stages_bar');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await LinearStagesBar.platformVersion, '42');
  });
}
