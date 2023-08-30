import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_security_checking_platform_interface.dart';

/// An implementation of [DeviceSecurityCheckingPlatform] that uses method channels.
class MethodChannelDeviceSecurityChecking
    extends DeviceSecurityCheckingPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_security_checking');

  @override
  FutureOr isEmulator() async {
    final value = await methodChannel.invokeMethod('isEmulator');
    return value;
  }

  @override
  FutureOr isDevModeOn() async {
    final value = await methodChannel.invokeMethod('isDevModeOn');
    return value;
  }

  @override
  FutureOr isRootedDevice() async {
    final value = await methodChannel.invokeMethod('isRootedDevice');
    return value;
  }

  @override
  FutureOr isTrustedDevice() async {
    final value = await methodChannel.invokeMethod('isTrustedDevice');
    return value;
  }
}
