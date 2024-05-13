import 'package:flutter/material.dart';


class VeriGirisi extends StatelessWidget {
  const VeriGirisi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Veri Girişi')),
      body: const Center(child: Text('Sıcaklık, yön,hız bilgileri buraya girilecek')),
    );
  }
}