#include "include/device_security_checking/device_security_checking_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "device_security_checking_plugin.h"

void DeviceSecurityCheckingPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  device_security_checking::DeviceSecurityCheckingPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
