import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothCls extends StatefulWidget {
  static BluetoothConnection? connection;

  const BluetoothCls({super.key});

  @override
  _BluetoothClsState createState() => _BluetoothClsState();
}

class _BluetoothClsState extends State<BluetoothCls> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    FlutterBluetoothSerial.instance.getBondedDevices().then((List<BluetoothDevice> devices) {
      setState(() {
        _devicesList = devices;
      });
    });
  }

  @override
  void dispose() {
    if (_connected) {
      BluetoothCls.connection?.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth Cihazları')),
      body: ListView(
        children: _devicesList.map((device) {
          return ListTile(
            title: Text(device.name ?? ''),
            subtitle: Text(device.address),
            onTap: () async {
              try {
                BluetoothConnection connection = await BluetoothConnection.toAddress(device.address);
                setState(() {
                  BluetoothCls.connection = connection;
                  _connected = true;
                });
                Navigator.pop(context);
              } catch (e) {
                setState(() {
                  _connected = false;
                });
              }
            },
          );
        }).toList(),
      ),
    );
  }
}