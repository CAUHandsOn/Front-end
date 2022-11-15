import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class StudentWidget extends StatefulWidget {
  const StudentWidget({Key? key}) : super(key: key);

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {
  final flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription? _subscription;
  var deviceid;
  void _ble_scan_start(){
    _subscription = flutterReactiveBle
        .scanForDevices(withServices: [], requireLocationServicesEnabled: false)
        .listen((device) {
          print('detect device id : ${device.id} // device.rrssi : ${device.rssi} // device.name : ${device.name}');
          deviceid = device.id;
        }, onError: (e){
          print('error : ${e.toString()}');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 페이지'),
      ),
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
              child: Text("hi"),
              onPressed: () async {
                await [Permission.bluetoothScan].request();
                await [Permission.bluetoothConnect].request();
                _ble_scan_start();
              },
            )
          ],
        ),
      ),
    );
  }
}
