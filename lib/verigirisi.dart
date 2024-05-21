import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert';
import 'dart:typed_data';

class VeriGirisi extends StatelessWidget {
  final BluetoothConnection? bluetoothConnection;
  final BluetoothDevice? connectedDevice;

  const VeriGirisi({Key? key, this.bluetoothConnection, this.connectedDevice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController veriController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Veri Girişi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              connectedDevice != null ? 'Bağlı Cihaz: ${connectedDevice!.name}' : 'Cihaz Bağlı Değil',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: veriController,
              decoration: const InputDecoration(labelText: 'Veri'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (bluetoothConnection != null && bluetoothConnection!.isConnected) {
                  String data = veriController.text;
                  bluetoothConnection!.output.add(Uint8List.fromList(utf8.encode(data)));
                  print('Veri gönderildi: $data');
                } else {
                  print('Cihaz bağlı değil');
                }
              },
              child: const Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}