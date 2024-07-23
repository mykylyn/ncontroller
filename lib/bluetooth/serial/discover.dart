import 'dart:async';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:bluetooth_classic/models/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncontroller/bluetooth/serial/BluetoothDeviceListEntry.dart';

class DiscoveryPage extends StatefulWidget {
  final bool start;
  const DiscoveryPage({super.key, required this.start});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
      List<BluetoothDiscoveryResult>.empty(growable: true);
  bool isDiscovering = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDiscovering = widget.start;

    if (isDiscovering) {
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        final exisitingIndex = results.indexWhere(
            (element) => element.device.address == r.device.address);
        if (exisitingIndex >= 0) {
          results[exisitingIndex] = r;
        } else {
          results.add(r);
        }
      });
    });

    _streamSubscription!.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? Text('Discovering devices')
            : Text("Discovered devices"),
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: ListView.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext context, index) {
            BluetoothDiscoveryResult result = results[index];
            final device = result.device;
            final address = device.address;

            return BluetoothDeviceListEntry(
              device: device,
              rssi: result.rssi,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(device.name ?? "NO NAME"),
                        content: Text(device.address ?? "NO ADDRESS"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () async {
                              try {
                                bool bonded = false;
                                if (device.isBonded) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: const Text(
                                        "Unbonding from device"),));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content:
                                        const Text("Bonding with device"),
                                  ));

                                  bonded = (await FlutterBluetoothSerial
                                      .instance
                                      .bondDeviceAtAddress(address))!;

                                  print(
                                      'Bonding with ${device.address} has ${bonded ? 'succed' : 'failed'}.');

                                  setState(() {
                                    results[results.indexOf(result)] =
                                        BluetoothDiscoveryResult(
                                            device: BluetoothDevice(
                                              name: device.name ?? '',
                                              address: address,
                                              type: device.type,
                                              bondState: bonded
                                                  ? BluetoothBondState.bonded
                                                  : BluetoothBondState.none,
                                            ),
                                            rssi: result.rssi);
                                  });
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error occured while bonding")));
                              }
                            },
                            child: Text("Connect"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Close"),
                          ),
                        ],
                      );
                    });
              },
            );
          }),
    );
  }
}
