import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:device_security_checking/device_security_checking.dart';
import 'package:device_security_checking/device_security_checking_platform_interface.dart';
import 'package:device_security_checking/device_security_checking_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceSecurityCheckingPlatform
    with MockPlatformInterfaceMixin
    implements DeviceSecurityCheckingPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  FutureOr isDevModeOn() {
    // TODO: implement isDevModeOn
    throw UnimplementedError();
  }

  @override
  FutureOr isEmulator() {
    // TODO: implement isEmulator
    throw UnimplementedError();
  }

  @override
  FutureOr isRootedDevice() {
    // TODO: implement isRootedDevice
    throw UnimplementedError();
  }

  @override
  FutureOr isTrustedDevice() {
    // TODO: implement isTrustedDevice
    throw UnimplementedError();
  }
}

void main() {
  final DeviceSecurityCheckingPlatform initialPlatform = DeviceSecurityCheckingPlatform.instance;

  test('$MethodChannelDeviceSecurityChecking is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceSecurityChecking>());
  });

  // test('getPlatformVersion', () async {
  //   DeviceSecurityChecking deviceSecurityCheckingPlugin = DeviceSecurityChecking();
  //   MockDeviceSecurityCheckingPlatform fakePlatform = MockDeviceSecurityCheckingPlatform();
  //   DeviceSecurityCheckingPlatform.instance = fakePlatform;
  //
  //   expect(await deviceSecurityCheckingPlugin.getPlatformVersion(), '42');
  // });
}
