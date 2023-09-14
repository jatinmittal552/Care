import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
// import 'package:flutter_blue/flutter_blue.dart';
// // import 'package:flutter_blue/gen/flutterblue.pb.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

//
class bluetooth extends StatefulWidget {
  @override
  State<bluetooth> createState() => _bluetoothState();
}

class _bluetoothState extends State<bluetooth> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  late BluetoothDevice targetDevice;
  int? _rssi;

  @override
  void initState() {
    super.initState();
    check();

    // print("Connected device is : ${targetDevice?.name}");
    // print("rssi value is : ${ rssi}");

  }

  // void main() {
  //   // Start scanning for devices
  //   flutterBlue.startScan();
  //
  //   // Listen for RSSI updates
  //   flutterBlue.scanResults.listen((List<ScanResult> results) {
  //     for (ScanResult result in results) {
  //       // Get the device and listen for RSSI updates
  //       BluetoothDevice device = result.device;
  //       print(device.name);
  //       device.connect();
  //       _rssi=device.readRssi() as int?;
  //     }
  //   });
  // }

  Future check() async{
    bool isBluetoothOn = await flutterBlue.isOn;
      if (isBluetoothOn) {
        print("Bluetooth is On");
        // flutterBlue.startScan(timeout: Duration(seconds: 8));
        // flutterBlue.scanResults.listen((List<ScanResult> results){
        //   for(ScanResult result in results){
        //     print("heloo");
        //     print("${result.device.name} found! rssi : ${result.rssi}" );
        //     // if(result.advertisementData.connectable)
        //     // print("hii");
        //     // targetDevice=result.device;
        //       // print("Device name is : ${result.device.name}");
        //       // service(device);
        //   }
        // });
        // // await device.connect();
        //
        // // flutterBlue.stopScan();

        List<BluetoothDevice> devices = await flutterBlue.connectedDevices;
        print("helllo");
        for(BluetoothDevice device in devices){
          print("hiii");
          print("Connected device: ${device.name}");
          device.disconnect();
          device.connect();
          targetDevice = device;

          bool isConnected = device.state == BluetoothDeviceState.connected;

          print(isConnected);



          if(isConnected){
            print("plsssss");
          }
        }

          // _rssi=device.readRssi() ;

        // print("hii");
        // flutterBlue.connectedDevices.asStream().listen((List<BluetoothDevice> devices){
        //   for(BluetoothDevice device in devices) {
        //     print("Connected device is : ${device.name}");
        //   }});

        // List<BluetoothService> services= await
        // print(connectedDevice.length);
        // if (connectedDevice.isNotEmpty) {
        //   for(BluetoothDevice device in connectedDevice){
        //     print('\n\n\nName of device is : ${device.name}');
        //   }
        //
        // }else{
        //   print("No device is connected");
        // }
      }else{
      print("Bluetooth is not enabled");
      await AppSettings.openBluetoothSettings();
      }


      trying();


    // print("rssi value : ${targetDevice!.readRssi()}");


  }

  void trying() async {
    Timer.periodic(Duration(milliseconds: 5), (timer) async {

      final rssi = await targetDevice.readRssi();
      setState(() {
        _rssi = rssi;
      });
      if(rssi<-89 ){
        FlutterRingtonePlayer.playRingtone();
        timer.cancel();
      }
      print("Rssi value : ${_rssi}");
    });
  }
//   //
//   // Future service(BluetoothDevice device) async {
//   //   print("connected is : ${device.name}");
//   //   await device.connect();
//   //   List<BluetoothService> services = await device.discoverServices();
//   //   BluetoothService disService;
//   //   for(BluetoothService service in services){
//   //     if(service.uuid.toString().toUpperCase()=="0000180A-0000-1000-8000-00805F9B34FB"){
//   //       disService=service;
//   //       break;
//   //     }
//   //
//   //   }
//   //   await device.disconnect();
//   //
//   // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: 240.h,
          width: 180.w,
          color: Colors.blue,
          child: Center(child: Text("$_rssi dB",style: TextStyle(color: Colors.red,fontSize: 15),)),

        ),
      ),
    );
  }
}








