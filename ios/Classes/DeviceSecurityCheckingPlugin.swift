import Flutter
import UIKit

public class DeviceSecurityCheckingPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "device_security_checking", binaryMessenger: registrar.messenger())
    let instance = DeviceSecurityCheckingPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isEmulator":
        var isSimulator : Bool;
        isSimulator = simulatorChecker()
     result(isSimulator)
     case "isRootedDevice":
       var isJailBroken : Bool;
       isJailBroken = jailBrokenChecking()
     result(isJailBroken)
     case "isTrustedDevice":
       var isTrustedDevice : Bool;
       isTrustedDevice = trustedDeviceChecker()
     result(isTrustedDevice)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

   func simulatorChecker() -> Bool {
        var isSimulator:Bool?
#if targetEnvironment(simulator)
        isSimulator = true
#else
        isSimulator = false
#endif
        return isSimulator!



    }

  func devModeChecker() -> Bool {
      var isDevModeOn:Bool?

      if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
         let infoDictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
         let buildConfiguration = infoDictionary["BuildConfigurationName"] as? String {
          if buildConfiguration.lowercased() == "debug" {
              isDevModeOn = true;
          } else {
              isDevModeOn = false;
          }
      } else {
          print("Unable to determine app mode.")
      }
      
      
      
//      isDevModeOn = TARGET_OS_SIMULATOR != 0
      return isDevModeOn ?? false

    }

    func jailBrokenChecking() -> Bool {
        var isJailBroken:Bool?
#if JailBrokenChecker
        isJailBroken = true
#else
        isJailBroken = false
#endif
        return isJailBroken!
    }

    func trustedDeviceChecker() -> Bool {
        let isSimulator = simulatorChecker()
        let isJailBroken = jailBrokenChecking()

        return !isSimulator && !isJailBroken
    }

    var JailBrokenChecker: Bool {
        get {

            if JailBrokenHelper.checkURLSchemes() { return true }
            if JailBrokenHelper.isContainsSuspiciousApps() { return true }
            if JailBrokenHelper.isSuspiciousSystemPathsExists() { return true }
            return JailBrokenHelper.canEditSystemFiles()
        }
    }


    private struct JailBrokenHelper {

        static func checkURLSchemes() -> Bool {
            var flag: Bool!
            let urlSchemes = [
                "undecimus://",
                "sileo://",
                "zbra://",
                "filza://",
                "activator://",
                "cydia://"
            ]

            if Thread.isMainThread {
                flag = canOpenUrlFromList(urlSchemes: urlSchemes)
            } else {
                let semaphore = DispatchSemaphore(value: 0)
                DispatchQueue.main.async {
                    flag = canOpenUrlFromList(urlSchemes: urlSchemes)
                    semaphore.signal()
                }
                semaphore.wait()
            }
            return flag
        }

        private static func canOpenUrlFromList(urlSchemes: [String]) -> Bool {
            for urlScheme in urlSchemes {
                if let url = URL(string: urlScheme) {
                    if UIApplication.shared.canOpenURL(url) {
                        return true
                    }
                }
            }
            return false
        }

        static func isContainsSuspiciousApps() -> Bool {
            for path in suspiciousAppsPathToCheck {
                if FileManager.default.fileExists(atPath: path) {
                    return true
                }
            }
            return false
        }

        static func isSuspiciousSystemPathsExists() -> Bool {
            for path in suspiciousSystemPathsToCheck {
                if FileManager.default.fileExists(atPath: path) {
                    return true
                }
            }
            return false
        }

        static func canEditSystemFiles() -> Bool {
            let jailBreakText = "Developer Insider"
            do {
                try jailBreakText.write(toFile: jailBreakText, atomically: true, encoding: .utf8)
                return true
            } catch {
                return false
            }
        }

        /**
         Add more paths here to check for jail break
         */
        static var suspiciousAppsPathToCheck: [String] {
            return ["/Applications/Cydia.app",
                    "/Applications/blackra1n.app",
                    "/Applications/FakeCarrier.app",
                    "/Applications/Icy.app",
                    "/Applications/IntelliScreen.app",
                    "/Applications/MxTube.app",
                    "/Applications/RockApp.app",
                    "/Applications/SBSettings.app",
                    "/Applications/WinterBoard.app",
                    "/Applications/Snoop-itConfig.app",
                    "/Applications/Checkra1n.app",
                    "/Applications/HideJB.app",
                    "/Applications/Sileo.app",
                    "/Applications/FlyJB.app",
                    "/Applications/Zebra.app"
            ]
        }

        static var suspiciousSystemPathsToCheck: [String] {
            return ["/.bootstrapped_electra",
                    "/.cydia_no_stash",
                    "/.installed_unc0ver",
                    "/bin/bash",
                    "/bin/sh",
                    "/bin.sh",
                    "/etc/apt",
                    "/etc/apt/sources.list.d/electra.list",
                    "/etc/apt/sources.list.d/sileo.sources",
                    "/etc/apt/undecimus/undecimus.list",
                    "/etc/ssh/sshd_config",
                    "/jb/amfid_payload.dylib",
                    "/jb/jailbreakd.plist",
                    "/jb/libjailbreak.dylib",
                    "/jb/lzma",
                    "/jb/offsets.plist",
                    "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                    "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                    "/Library/MobileSubstrate/MobileSubstrate.dylib",
                    "/Library/dpkg/info/re.frida.server.list",
                    "/Library/LaunchDaemons/re.frida.server.plist",
                    "/Library/MobileSubstrate/CydiaSubstrate.dylib",
                    "/Library/MobileSubstrate/HideJB.dylib",
                    "/Library/PreferenceBundles/ABypassPrefs.bundle",
                    "/Library/PreferenceBundles/FlyJBPrefs.bundle",
                    "/Library/PreferenceBundles/HideJBPrefs.bundle",
                    "/Library/PreferenceBundles/LibertyPref.bundle",
                    "/Library/PreferenceBundles/ShadowPreferences.bundle",
                    "/private/var/lib/apt",
                    "/private/var/lib/apt/",
                    "/private/var/lib/cydia",
                    "/private/var/mobile/Library/SBSettings/Themes",
                    "/private/var/stash",
                    "/private/var/tmp/cydia.log",
                    "/private/etc/apt",
                    "/private/etc/dpkg/origins/debian",
                    "/private/etc/ssh/sshd_config",
                    "/private/var/cache/apt/",
                    "/private/var/log/syslog",
                    "/private/var/mobileLibrary/SBSettingsThemes/",
                    "/private/var/Users/",
                    "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                    "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                    "/usr/bin/sshd",
                    "/usr/libexec/sftp-server",
                    "/usr/sbin/sshd",
                    "/usr/libexec/ssh-keysign",
                    "/usr/bin/cycript",
                    "/usr/bin/ssh",
                    "/usr/lib/libcycript.dylib",
                    "/usr/lib/libhooker.dylib",
                    "/usr/lib/libjailbreak.dylib",
                    "/usr/lib/libsubstitute.dylib",
                    "/usr/lib/substrate",
                    "/usr/lib/TweakInject",
                    "/usr/libexec/cydia/",
                    "/usr/libexec/cydia/firmware.sh",
                    "/usr/local/bin/cycrip",
                    "/usr/sbin/frida-server",
                    "/usr/share/jailbreak/injectme.plist",
                    "/usr/lib/ABDYLD.dylib",
                    "/usr/lib/ABSubLoader.dylib",
                    "/var/binpack",
                    "/var/cache/apt",
                    "/var/checkra1n.dmg",
                    "/var/lib/apt",
                    "/var/lib/cydia",
                    "/var/lib/dpkg/info/mobilesubstrate.md5sums",
                    "/var/mobile/Library/Preferences/ABPattern",
                    "/var/log/apt",
                    "/var/log/syslog",
                    "/var/tmp/cydia.log",
                    "/var/binpack/Applications/loader.app"
            ]
        }
    }


}
