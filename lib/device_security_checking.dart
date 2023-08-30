import 'dart:async';

import 'device_security_checking_platform_interface.dart';

class DeviceSecurityChecking {
  FutureOr emulatorChecking() {
    return DeviceSecurityCheckingPlatform.instance.isEmulator();
  }

  FutureOr developerModeChecking() {
    return DeviceSecurityCheckingPlatform.instance.isDevModeOn();
  }

  FutureOr rootedDeviceChecking() {
    return DeviceSecurityCheckingPlatform.instance.isRootedDevice();
  }

  FutureOr trustedDeviceChecking() {
    return DeviceSecurityCheckingPlatform.instance.isTrustedDevice();
  }
}
