import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homojenizator/verigirisi.dart';
import 'package:homojenizator/bluetooth.dart';

void main() {
  runApp(const Homojenizator());
}

class Homojenizator extends StatelessWidget {
  const Homojenizator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDCEDC8),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[600],
        title: const Text(
          "HOMOJENİZATÖR",
          style: TextStyle(
            color: Color(0xFFDCEDC8),
            fontSize: 24,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Color(0xFFDCEDC8)),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BluetoothCls()),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.all(16),
                width: 250,
                height: 175,
                decoration: BoxDecoration(
                  color: Colors.lightGreen[600],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 8, height: 30),
                        Icon(
                          Icons.bluetooth,
                          color: Color(0xFFDCEDC8),
                          size: 70,
                        ),
                        SizedBox(width: 8), // İkon ile metin arasına boşluk ekledik
                      ],
                    ),
                    Positioned(
                      bottom: 30,
                      left: 12,
                      top: 75,
                      child: Text(
                        'Cihaza Bağlan',
                        style: TextStyle(
                          color: Color(0xFFDCEDC8),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VeriGirisi(bluetoothConnection: BluetoothCls.connection)),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.all(16),
                width: 250,
                height: 175,
                decoration: BoxDecoration(
                  color: Colors.lightGreen[600],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 8, height: 30),
                        Icon(
                          Icons.account_tree_outlined,
                          color: Color(0xFFDCEDC8),
                          size: 70,
                        ),
                        SizedBox(width: 8), // İkon ile metin arasına boşluk ekledik
                      ],
                    ),
                    Positioned(
                      bottom: 30,
                      left: 42,
                      top: 75,
                      child: Text(
                        'Veri Girişi',
                        style: TextStyle(
                          color: Color(0xFFDCEDC8),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}