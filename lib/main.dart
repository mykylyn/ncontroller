import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncontroller/usb_serial.dart';
import 'dart:math' as math;
import 'button_mode.dart';
import 'bluetooth/ble/blue_let.dart';
import 'usb_serial.dart';
import 'game_controls.dart';
import 'package:ncontroller/bluetooth/serial/discover.dart';
import 'package:material_theme_builder/material_theme_builder.dart';

void main() {
  runApp(const MyApp());
}

computeRollAngle(List<dynamic> arguments) {
  SendPort sendPort = arguments[0];
  double x = arguments[1];
  double y = arguments[2];
  double z = arguments[3];
  var rollAngle = math.atan2(y, math.sqrt(x * x + z * z)) * 180 / math.pi;
  sendPort.send(rollAngle);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.``
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controller',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          colorScheme: MaterialThemeBuilder(
        brightness: Brightness.dark,
        primary: const Color(0xFF2E9D9D),
        secondary: Color(0XFF809594),
        tertiary: Color(0XFF8292AB),
        error: Color(0XFFFF5449),
        neutral: Color(0XFF8F9191),
      ).toScheme()),
      debugShowCheckedModeBanner: false,
      //home: const MyHomePage(title: "Controller"),
      //home: BleScanner(),
      //home  Joystickview(),
      //home:MyApp(),
      home: DiscoveryPage(start: true,),
      //home:UsbMode(),
    );
  }
}
