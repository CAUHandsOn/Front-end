import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BluetoothTestProvider extends ChangeNotifier{
  final List<DiscoveredDevice> _discoveredDevice = List.empty(growable: true);

  List<DiscoveredDevice> get discoveredDeviceList => _discoveredDevice;

  addToList(DiscoveredDevice device){
    _discoveredDevice.add(device);
    notifyListeners();
  }
}