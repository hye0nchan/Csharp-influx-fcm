import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class FunctionBox {
  void changeVisibilityLists(int changeDataNumber) {
    int i = changeDataNumber;
    for (int j = 0; j < visibilityMap.length; j++) {
      visibilityMap.update(j, (value) => false);
    }
    visibilityMap.update(i, (value) => true);
  }

  void changeVisibilityOnLists(int changeDataNumber) {
    int i = changeDataNumber;
    for (int j = 0; j < visibilityOnMap.length; j++) {
      visibilityOnMap.update(j, (value) => false);
    }
    visibilityOnMap.update(i, (value) => true);
  }

  void changeVisibilityRefreshLists(int changeDataNumber) {
    int i = changeDataNumber;
    for (int j = 0; j < visibilityRefreshMap.length; j++) {
      visibilityRefreshMap.update(j, (value) => false);
    }
    visibilityRefreshMap.update(i, (value) => true);
  }

  void changeVisibilityDialogLists(int changeDataNumber) {
    int i = changeDataNumber;
    for (int j = 0; j < visibilityDialogMap.length; j++) {
      visibilityDialogMap.update(j, (value) => false);
    }
    visibilityDialogMap.update(i, (value) => true);
  }

  void changeVisibilityStatScreenLists(int changeDataNumber) {
    int i = changeDataNumber;
    for (int j = 0; j < visibilityStatScreenMap.length; j++) {
      visibilityStatScreenMap.update(j, (value) => false);
    }
    visibilityStatScreenMap.update(i, (value) => true);
  }

  void changeVisibilityMenuLists(int changeDataNumber) {
    int i = changeDataNumber;
    for (int j = 0; j < visibilityMenuMap.length; j++) {
      visibilityMenuMap.update(j, (value) => false);
    }
    visibilityMenuMap.update(i, (value) => true);
  }

  void changeIsCheckedLists(int changeDataNumber) {
    int i = changeDataNumber;
    isCheckedMap.update(i, (value) => !value);
  }

  void readGatewayFunc() async {
    final prefs = await SharedPreferences.getInstance();
    saveGateway = prefs.getStringList("myGateway") ?? [""];
    print(saveGateway);
    for (int i = 0; i < saveGateway.length; i++) {
      if (!gatewayID.contains(saveGateway[i])) {
        if (saveGateway[i] != "") {
          gatewayID.add(saveGateway[i]);
          gatewayID.sort();
        }
      }
    }
  }

  void readDeviceFunc() async {
    final prefs = await SharedPreferences.getInstance();
    saveDevice = prefs.getStringList("myDevice") ?? [""];
    print(saveDevice);
    for (int i = 0; i < saveDevice.length; i++) {
      if (!deviceID.contains(saveDevice[i])) {
        if (saveDevice[i] != "") {
          deviceID.add(saveDevice[i]);
          deviceID.sort();
        }
      }
    }
  }
}
