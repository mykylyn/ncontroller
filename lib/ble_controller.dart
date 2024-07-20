import 'dart:async';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

class BleController extends GetxController {
  Future scanDevices() async {
    print("start here");
    if (await Permission.bluetoothScan.request().isGranted) {
      if (await Permission.bluetoothConnect.request().isGranted) {
        await FlutterBluePlus.startScan(
          timeout: const Duration(seconds: 10),
        );

        // Listen to the scan results stream
        /*final scanSubscription =
            FlutterBluePlus.scanResults.listen((scanResults) {
          for (final ScanResult result in scanResults) {
            print(
                'Found device: ${result.device.platformName} - ${result.device.remoteId.str}');
          }
        });
        */

        // Stop scanning after the timeout or when explicitly called
        await Future.delayed(const Duration(seconds: 10));
        FlutterBluePlus.stopScan(); 
        
        //scanSubscription.cancel();
        
      }
    } else {
      // Handle Bluetooth disabled case (e.g., show a message)
      print('Bluetooth is not enabled. Please enable it to scan devices.');
    }
  }

  Stream<List<ScanResult>> get scanRe => FlutterBluePlus.scanResults;
  //StreamSubscription<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults
  //    .listen((results) => print('Scan Results: $results'));
}
