import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'litmus_cx_library_platform_interface.dart';

/// An implementation of [LitmusCxLibraryPlatform] that uses method channels.
class MethodChannelLitmusCxLibrary extends LitmusCxLibraryPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('litmus_cx_library');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
