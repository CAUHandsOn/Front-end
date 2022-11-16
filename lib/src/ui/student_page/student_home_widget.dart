import 'dart:async';
import 'package:handson/src/provider/bluetooth_test_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';


class StudentWidget extends StatefulWidget {
  const StudentWidget({Key? key}) : super(key: key);

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> {

  final flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription? _subscription;
  late List<DiscoveredDevice> deviceList;
  late BluetoothTestProvider bLEprovider;
  var _status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bLEprovider = Provider.of<BluetoothTestProvider>(context, listen: false);
    deviceList = bLEprovider.discoveredDeviceList;
    setStatus();
  }

  void _ble_scan_start(){
    _subscription = flutterReactiveBle
        .scanForDevices(withServices: [], requireLocationServicesEnabled: false)
        .listen((device) {
          print('detect device id : ${device.id} // device.rrssi : ${device.rssi} // device.name : ${device.name}');
          // flutterToast("${device.id} ${device.rssi} ${device.name}");

          bLEprovider.addToList(device);
        }, onError: (e){
          print('error : ${e.toString()}');
    });
  }

  void setStatus(){
    flutterReactiveBle.statusStream.listen((status) {
      if (BleStatus.poweredOff == status){
        print("powered off");
      } else if (BleStatus.ready == status) {
        print("ready ble");
      } else if (BleStatus.unauthorized == status) {
        print("unauthorized ble");
      }
      _status = status;
    });
  }

  void _ble_scan_stop(){
    _subscription?.cancel();
    _subscription = null;
  }

  void flutterToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학생 페이지'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: Provider.of<BluetoothTestProvider>(context, listen: true).discoveredDeviceList.length,
                itemBuilder: (context, index){
                  return ListTile(
                    onTap: (){},
                    leading: Icon(Icons.bluetooth),
                    title: Text("${Provider.of<BluetoothTestProvider>(context, listen: true).discoveredDeviceList[index].name}"),
                    subtitle: Text("${Provider.of<BluetoothTestProvider>(context, listen: true).discoveredDeviceList[index].id}"),
                    trailing: Text("${Provider.of<BluetoothTestProvider>(context, listen: true).discoveredDeviceList[index].rssi}"),
                  );
                },
                separatorBuilder: (BuildContext context, int index){
                  return const Divider();
                },
              ),
              ElevatedButton(
                child: const Text("버튼"),
                onPressed: () async {
                  await [Permission.bluetoothScan].request();
                  await [Permission.bluetoothConnect].request();
                  _ble_scan_start();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
