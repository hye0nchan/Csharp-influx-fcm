// ignore_for_file: unused_element

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartfarm_dashboard/data/data.dart';

class FunctionBox{

  void _readGateway() async{
    final prefs = await SharedPreferences.getInstance();
    saveGateway = prefs.getStringList('my_string_key');
    gatewayID = prefs.getStringList('my_string_key');
    print(saveGateway);
    for(int i = 0; i<saveGateway.length; i++) {
      if (!gatewayID.contains(saveGateway[i])) {
        gatewayID.add(saveGateway[i]);
        gatewayID.sort();
      }
    }
  }

  void _saveGateway(String saveData) async{
    final prefs = await SharedPreferences.getInstance();
    String value = saveData;
    String key = 'my_string_key';
    if(!gatewayID.contains(value)){
      gatewayID.insert(0,value);
      prefs.setStringList(key, gatewayID);
      print(key);
      print('value' " $gatewayID");
    }
  }

  void _readDevice() async{
    final prefs = await SharedPreferences.getInstance();
    saveDevice = prefs.getStringList('my_string_key_Device');
    deviceID = prefs.getStringList('my_string_key_Device');
    print(saveDevice);
    for(int i = 0; i<saveDevice.length??0; i++) {
      if (!deviceID.contains(saveDevice[i])) {
        deviceID.add(saveDevice[i]);
        deviceID.sort();
      }
    }
  }

  void _saveDevice(String saveData) async {
    final prefs = await SharedPreferences.getInstance();
    String value = saveData;
    String key = 'my_string_key_Device';
    if (!deviceID.contains(value)) {
      deviceID.insert(0, value);
      prefs.setStringList(key, deviceID);
      print(key);
      print('value' " $deviceID");
    }
  }
}
