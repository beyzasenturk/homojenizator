import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'verigirisi.dart';

class BluetoothCls extends StatefulWidget {
  static BluetoothConnection? connection;
  static BluetoothDevice? connectedDevice;

  const BluetoothCls({Key? key}) : super(key: key);

  @override
  _BluetoothClsState createState() => _BluetoothClsState();
}

class _BluetoothClsState extends State<BluetoothCls> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> _devicesList = [];
  List<BluetoothDiscoveryResult> _scanResults = [];
  bool _isDiscovering = false;

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

    _startDiscovery();
  }

  void _startDiscovery() {
    _scanResults.clear();
    setState(() {
      _isDiscovering = true;
    });

    FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
      setState(() {
        _scanResults.add(result);
      });
    }).onDone(() {
      setState(() {
        _isDiscovering = false;
      });
    });
  }

  @override
  void dispose() {
    if (BluetoothCls.connection != null) {
      BluetoothCls.connection!.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<BluetoothDevice> _allDevices = _devicesList +
        _scanResults
            .map((result) => result.device)
            .where((device) => !_devicesList.contains(device))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Cihazları'),
        actions: [
          _isDiscovering
              ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _startDiscovery,
          ),
        ],
      ),
      body: ListView(
        children: _allDevices.map((device) {
          // Cihaz adı var mı kontrol et
          if (device.name != null && device.name!.isNotEmpty) {
            return ListTile(
              title: Text(device.name!),
              subtitle: Text(device.address),
              onTap: () async {
                try {
                  print('Bağlanmaya çalışılıyor: ${device.address}');
                  BluetoothConnection connection = await BluetoothConnection.toAddress(device.address!);
                  setState(() {
                    BluetoothCls.connection = connection;
                    BluetoothCls.connectedDevice = device;
                  });
                  print('Bağlantı başarılı: ${device.name} (${device.address})');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VeriGirisi(
                        bluetoothConnection: BluetoothCls.connection,
                        connectedDevice: BluetoothCls.connectedDevice,
                      ),
                    ),
                  );
                } catch (e) {
                  print('Bağlantı hatası: $e');
                }
              },
            );
          } else {
            // Cihaz adı yoksa ListTile oluşturma
            return SizedBox.shrink();
          }
        }).toList(),
      ),
    );
  }
}
