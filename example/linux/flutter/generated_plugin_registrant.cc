//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <device_security_checking/device_security_checking_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) device_security_checking_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DeviceSecurityCheckingPlugin");
  device_security_checking_plugin_register_with_registrar(device_security_checking_registrar);
}
