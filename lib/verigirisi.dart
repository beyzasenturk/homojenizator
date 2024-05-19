import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert';
import 'dart:typed_data';

class VeriGirisi extends StatelessWidget {
  final BluetoothConnection? bluetoothConnection;

  const VeriGirisi({Key? key, this.bluetoothConnection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController hizController = TextEditingController();
    final TextEditingController yonController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Veri Girişi')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: hizController,
              decoration: const InputDecoration(labelText: 'Hız'),
            ),
            TextField(
              controller: yonController,
              decoration: const InputDecoration(labelText: 'Yön'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String hiz = hizController.text;
                String yon = yonController.text;

                if (bluetoothConnection != null && bluetoothConnection!.isConnected) {
                  bluetoothConnection!.output.add(Uint8List.fromList(utf8.encode('$hiz,$yon\n')));
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