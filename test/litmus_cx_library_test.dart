import 'package:flutter_test/flutter_test.dart';
import 'package:litmus_cx_library/litmus_cx_library.dart';
import 'package:litmus_cx_library/litmus_cx_library_platform_interface.dart';
import 'package:litmus_cx_library/litmus_cx_library_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLitmusCxLibraryPlatform
    with MockPlatformInterfaceMixin
    implements LitmusCxLibraryPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LitmusCxLibraryPlatform initialPlatform =
      LitmusCxLibraryPlatform.instance;

  test('$MethodChannelLitmusCxLibrary is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLitmusCxLibrary>());
  });

  test('getPlatformVersion', () async {
    LitmusCxLibrary litmusCxLibraryPlugin = LitmusCxLibrary();
    MockLitmusCxLibraryPlatform fakePlatform = MockLitmusCxLibraryPlatform();
    LitmusCxLibraryPlatform.instance = fakePlatform;

    // expect(await litmusCxLibraryPlugin.getPlatformVersion(), '42');
  });
}
