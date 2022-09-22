import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:litmus_cx_library/litmus_cx_library_method_channel.dart';

void main() {
  MethodChannelLitmusCxLibrary platform = MethodChannelLitmusCxLibrary();
  const MethodChannel channel = MethodChannel('litmus_cx_library');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
