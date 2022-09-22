import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'litmus_cx_library_method_channel.dart';

abstract class LitmusCxLibraryPlatform extends PlatformInterface {
  /// Constructs a LitmusCxLibraryPlatform.
  LitmusCxLibraryPlatform() : super(token: _token);

  static final Object _token = Object();

  static LitmusCxLibraryPlatform _instance = MethodChannelLitmusCxLibrary();

  /// The default instance of [LitmusCxLibraryPlatform] to use.
  ///
  /// Defaults to [MethodChannelLitmusCxLibrary].
  static LitmusCxLibraryPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LitmusCxLibraryPlatform] when
  /// they register themselves.
  static set instance(LitmusCxLibraryPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
