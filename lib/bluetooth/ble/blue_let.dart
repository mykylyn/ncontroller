// Import the necessary packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:ncontroller/bluetooth/ble/ble_controller.dart';

class BleScanner extends StatefulWidget {
  const BleScanner({super.key});

  @override
  State<BleScanner> createState() => _BleScannerState();
}

class _BleScannerState extends State<BleScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ble scanner'),
      ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (BleController controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.scanDevices();
                  },
                  child: Text("Scan"),
                ),
                SizedBox(
                  height: 10,
                ),
                StreamBuilder<List<ScanResult>>(
                    stream: controller.scanRe,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.hasData);
                        print(snapshot.data);
                        print(snapshot.data!.length);
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data![index];
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(data.device.platformName),
                                  subtitle: Text(data.device.remoteId.str),
                                  trailing: Text(data.rssi.toString()),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text("No Device Found"),
                        );
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
