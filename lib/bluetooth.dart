import 'package:flutter/material.dart';

class BluetoothCls extends StatelessWidget {
  const BluetoothCls({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth Cihazları')),
      body: const Center(child: Text('Bluetooth sayfası')),
    );
  }
}
