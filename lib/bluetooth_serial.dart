// import 'dart:async';
// import 'dart:ui';
// import 'package:app_settings/app_settings.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class bluetooth_serial extends StatefulWidget {
//
//   @override
//   State<bluetooth_serial> createState() => _bluetooth_serial();
// }
//
// class _bluetooth_serial extends State<bluetooth_serial> {
//   BluetoothDevice? targetDevice;
//   BluetoothConnection? connection;
//   Timer? _timer;
//   @override
//   void initState(){
//     super.initState();
//     check();
//
//   }
//   Future check() async{
//     bool? bluetooth_availibilty = await FlutterBluetoothSerial.instance.isEnabled;
//     bool checking = bluetooth_availibilty!;
//     if(!checking){
//       await AppSettings.openBluetoothSettings();
//     }else{
//       List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();
//       for(BluetoothDevice device in devices){
//         if(device!=null){
//           print("Connected device is : ${device.name}");
//         }
//         if(device.isConnected){
//           setState((){
//             targetDevice=device;
//           });
//         }
//       }
//     }
//     if(targetDevice!=null){
//       print("My device is ${targetDevice!.name}");
//       connection = await BluetoothConnection.toAddress(targetDevice!.address)
//       print("There is no connected device");
//     }
//     // print("My device is ${targetDevice?.name}");
//     // BluetoothConnection connection = await BluetoothConnection.toAddress("00:11:22:33:44:55");
//     // BluetoothDevice device;
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 100.h,
//           width: 100.h,
//           color: Colors.blue,
//           child: Text("My device is : ${targetDevice?.name}",style: TextStyle(fontSize: 20.sp),)
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';



class MyHome extends StatefulWidget {

  @override
  State<MyHome> createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _device;
  bool _connected = false;
  bool _pressed = false;
  BluetoothConnection? _connection;
  int? _rssi;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];

    try {
      _bluetoothState = await _bluetooth.state;
      devices = await _bluetooth.getBondedDevices();

    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _devicesList = devices;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("hii"),
      ),
      body: Container(
        height: 300,
        width: 300,
        color: Colors.blue,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Device:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
                    items: _getDeviceItems(),
                    onChanged: (value) => setState(() => _device = value),
                    value: _device,
                  ),
                  ElevatedButton(
                    onPressed:
                    _pressed ? null : _connected ? _disconnect : _connect,
                    child: Text(_connected ? 'Disconnect' : 'Connect'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('RSSI: ${_device}'),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text("${device.name}"),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() async {
    if (_device == null) {
      show('No device selected.');
    } else {
      if (!_connected) {
        await _bluetooth.connect(_device!).catchError((error) {
          setState(() => _pressed = false);
        });
        setState(() => _connected = true);
        show('Device connected');
      }
    }
  }

  void _disconnect() async {
    setState(() => _pressed = true);
    // ignore: deprecated_member_use
    await _bluetooth.disconnect();
    setState(() => _connected = false);
    show('Device disconnected');
  }

  void show(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

