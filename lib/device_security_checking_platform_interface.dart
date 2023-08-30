import 'dart:async';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_security_checking_method_channel.dart';

abstract class DeviceSecurityCheckingPlatform extends PlatformInterface {
  /// Constructs a DeviceSecurityCheckingPlatform.
  DeviceSecurityCheckingPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceSecurityCheckingPlatform _instance =
      MethodChannelDeviceSecurityChecking();

  /// The default instance of [DeviceSecurityCheckingPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceSecurityChecking].
  static DeviceSecurityCheckingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceSecurityCheckingPlatform] when
  /// they register themselves.
  static set instance(DeviceSecurityCheckingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  FutureOr isEmulator() {
    throw UnimplementedError('isEmulator() has not been implemented.');
  }

  FutureOr isDevModeOn() {
    throw UnimplementedError('isDevModeOn() has not been implemented.');
  }

  FutureOr isRootedDevice() {
    throw UnimplementedError('isRootedDevice() has not been implemented.');
  }

  FutureOr isTrustedDevice() {
    throw UnimplementedError('isTrustedDevice() has not been implemented.');
  }
}
