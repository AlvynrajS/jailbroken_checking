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
    getValues();
    super.initState();
  }

  Future<void> getValues() async {
    var a = await _deviceSecurityCheckingPlugin.trustedDeviceChecking();
    var b = await _deviceSecurityCheckingPlugin.emulatorChecking();
    var d = await _deviceSecurityCheckingPlugin.rootedDeviceChecking();
    var c;
    if (Platform.isAndroid) {
      c = await _deviceSecurityCheckingPlugin.developerModeChecking();
    }
    setState(() {
      isTrusted = a;
      isEmulator = b;
      isRooted = d;
      if (Platform.isAndroid) {
        isDevModeOn = c;
      }
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((Platform.isAndroid)
                        ? 'Rooted Device :'
                        : 'Jail Broken Device :'),
                    Text(' $isRooted'),
                  ],
                ),
              ),
              Text('Trusted Device : $isTrusted'),
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
