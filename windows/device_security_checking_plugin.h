#ifndef FLUTTER_PLUGIN_DEVICE_SECURITY_CHECKING_PLUGIN_H_
#define FLUTTER_PLUGIN_DEVICE_SECURITY_CHECKING_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace device_security_checking {

class DeviceSecurityCheckingPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DeviceSecurityCheckingPlugin();

  virtual ~DeviceSecurityCheckingPlugin();

  // Disallow copy and assign.
  DeviceSecurityCheckingPlugin(const DeviceSecurityCheckingPlugin&) = delete;
  DeviceSecurityCheckingPlugin& operator=(const DeviceSecurityCheckingPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace device_security_checking

#endif  // FLUTTER_PLUGIN_DEVICE_SECURITY_CHECKING_PLUGIN_H_
