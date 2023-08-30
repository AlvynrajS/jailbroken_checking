import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:device_security_checking/device_security_checking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isEmulator = false;
  bool isLoading = false;
  bool isDevModeOn = false;
  bool isRooted = false;
  bool isTrusted = false;
  final _deviceSecurityCheckingPlugin = DeviceSecurityChecking();

  @override
  void initState() {
    isRealDevice();
    isDevMode();
    isRootedDevice();
    isTrustedDevice();
    super.initState();
  }

  Future<void> isRealDevice() async {
    var result;
    setState(() {
      isLoading = true;
    });
    try {
      result = await _deviceSecurityCheckingPlugin.emulatorChecking();
      setState(() {
        isEmulator = result;
      });
    } catch (e) {
      alert(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> isDevMode() async {
    var result;
    setState(() {
      isLoading = true;
    });
    try {
      result = await _deviceSecurityCheckingPlugin.developerModeChecking();
      setState(() {
        isDevModeOn = result;
      });
    } catch (e) {
      alert(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> isRootedDevice() async {
    var result;
    setState(() {
      isLoading = true;
    });
    try {
      result = await _deviceSecurityCheckingPlugin.rootedDeviceChecking();
      setState(() {
        isRooted = result;
      });
    } catch (e) {
      alert(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> isTrustedDevice() async {
    var result;
    setState(() {
      isLoading = true;
    });
    try {
      result = await _deviceSecurityCheckingPlugin.trustedDeviceChecking();
      setState(() {
        isTrusted = result;
      });
    } catch (e) {
      alert(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Emulator Device : $isEmulator'),
              const SizedBox(height: 20),
              if (Platform.isAndroid) Text('Dev mode on : $isDevModeOn'),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text((Platform.isAndroid)
                      ? 'Rooted Device :'
                      : 'Jail Broken Device :'),
                  Text(' $isRooted'),
                ],
              ),
              const SizedBox(height: 20),
              Text('Trusted Device : $isTrusted'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future alert(String content) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(content),
          );
        });
  }
}
