// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smartfarm_dashboard/config/palette.dart';
// import 'package:smartfarm_dashboard/data/data.dart';
//
// class CustomDrawer extends StatefulWidget {
//   @override
//   _CustomDrawerState createState() => _CustomDrawerState();
// }
//
// class _CustomDrawerState extends State<CustomDrawer> {
//   //리스트 변수
//   List<String> valueListGateway = [];
//   List<String> valueListDevice = [];
//
//   // 시작할 때 실행 (setState와 동일한 기능)
//   @override
//   void initState() {
//     readGatewayFunc();
//   }
//
//   void readGatewayFunc() async {
//     final prefs = await SharedPreferences.getInstance();
//     saveGateway = prefs.getStringList("myGateway") ?? [""];
//     print(saveGateway);
//     for (int i = 0; i < saveGateway.length; i++) {
//       if (!gatewayID.contains(saveGateway[i])) {
//         if (saveGateway[i] != "") {
//           setState(() {
//             gatewayID.add(saveGateway[i]);
//             gatewayID.sort();
//           });
//         }
//       }
//     }
//   }
//
//   void readDeviceFunc() async {
//     final prefs = await SharedPreferences.getInstance();
//     saveDevice = prefs.getStringList("myDevice") ?? [""];
//     print(saveDevice);
//     for (int i = 0; i < saveDevice.length; i++) {
//       if (!deviceID.contains(saveDevice[i])) {
//         if (saveDevice[i] != "") {
//           setState(() {
//             deviceID.add(saveDevice[i]);
//             deviceID.sort();
//           });
//         }
//       }
//     }
//   }
//
//   void saveGatewayFunc(String saveData) async {
//     final prefs = await SharedPreferences.getInstance();
//     String value = saveData;
//     if (!gatewayID.contains(value)) {
//       gatewayID.add(value);
//       valueListGateway.add(value);
//       prefs.setStringList("myGateway", valueListGateway);
//       print('value' " $valueListGateway");
//     }
//   }
//
//   void saveDeviceFunc(String saveData) async {
//     final prefs = await SharedPreferences.getInstance();
//     String value = saveData;
//     if (!deviceID.contains(value)) {
//       deviceID.add(value);
//       valueListDevice.add(value);
//       prefs.setStringList("myDevice", valueListDevice);
//       print('value' " $valueListDevice");
//     }
//   }
//
//   void addGateway() {
//     setState(() {
//       saveGatewayFunc(gatewayController.text);
//     });
//   }
//
//   void addDevice() {
//     setState(() {
//       saveDeviceFunc(deviceController.text);
//     });
//   }
//
//   //미완 (삭제 기능 오류)
//   Future<void> delDevice() async {
//     final prefs = await SharedPreferences.getInstance();
//     //기존에 가지고 있던 값 저장
//     delDeviceList = prefs.getStringList("myDevice");
//
//     // 데이터 리스트에 저장되어 있는 값 제거
//     delDeviceList.remove(selectedDeviceID);
//
//     // 현재 리스트에 있는 값 제거 (오류)
//     setState(() {
//       deviceID.remove(selectedDeviceID);
//     });
//
//     // 값 제거 후 다시 저장
//     prefs.setStringList("myDevice", delDeviceList);
//   }
//
//   Future<void> delGateway() async {
//     final prefs = await SharedPreferences.getInstance();
//     List<String> delGatewayList = prefs.getStringList("myGateway");
//
//     prefs.setStringList("myGateway", delGatewayList);
//     int index = gatewayID.indexOf(selectedGateway);
//     print(index);
//     print(gatewayID[index]);
//     gatewayID[index] = "12";
//     setState(() {
//       // gatewayID[index] = "";
//       delGatewayList.remove(selectedGateway);
//       saveGateway.remove(selectedGateway);
//     });
//
//     int delIndex = gatewayID.indexOf(selectedGateway);
//     int changeIndex = gatewayID.indexOf(gatewayID[delIndex + 1]);
//     String box;
//     setState(() {
//       box = gatewayID[changeIndex];
//       gatewayID[changeIndex] = gatewayID[delIndex];
//       gatewayID[delIndex] = box;
//       gatewayID.removeAt(changeIndex);
//     });
//     int index2 = gatewayID.indexOf(selectedGateway);
//     print(index);
//     for (int i = 0; i < gatewayID.length; i++) {
//       if (i > index) {
//         setState(() {
//           gatewayID[index] = gatewayID[i];
//         });
//       }
//     }
//   }
//
//   //사용 예정
//   void changeIndexGateway() {
//     int index = gatewayID.indexOf(selectedGateway);
//     setState(() {
//       selectedGateway = gatewayID[index - 1];
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//         child: ListView(padding: EdgeInsets.zero, children: [
//       Container(
//         height: 150,
//         child: DrawerHeader(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Control Gateway or Device',
//                 style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 20,
//                     color: Colors.white),
//               ),
//             ],
//           ),
//           decoration: BoxDecoration(
//             color: Palette.primaryColor,
//           ),
//         ),
//       ),
//       SizedBox(
//         height: 30,
//       ),
//       Text(
//         "Gateway BOX",
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Container(
//         margin: const EdgeInsets.symmetric(
//           horizontal: 50.0,
//           vertical: 10.0,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
//         decoration: BoxDecoration(
//             color: Palette.primaryColor,
//             borderRadius: BorderRadius.circular(20.0)),
//         alignment: Alignment.center,
//         child: DropdownButtonFormField(
//           decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Palette.primaryColor))),
//           onTap: readGatewayFunc,
//           dropdownColor: Palette.primaryColor,
//           value: selectedGateway,
//           items: gatewayID
//               .map((e) => DropdownMenuItem(
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           e,
//                           style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         )
//                       ],
//                     ),
//                     value: e,
//                   ))
//               .toList(),
//           onChanged: (value) {
//             setState(() {
//               selectedGateway = value;
//               sendGateway = value;
//             });
//           },
//         ),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 150,
//             child: TextField(
//               controller: gatewayController,
//               decoration: InputDecoration(),
//             ),
//           ),
//           IconButton(onPressed: addGateway, icon: Icon(Icons.add)),
//           IconButton(onPressed: delGateway, icon: Icon(Icons.remove)),
//         ],
//       ),
//       SizedBox(
//         height: 30,
//       ),
//       Text(
//         "Device BOX",
//         textAlign: TextAlign.center,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
//       ),
//       SizedBox(
//         height: 10,
//       ),
//       Container(
//         margin: const EdgeInsets.symmetric(
//           horizontal: 50.0,
//           vertical: 10.0,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
//         decoration: BoxDecoration(
//             color: Palette.primaryColor,
//             borderRadius: BorderRadius.circular(20.0)),
//         alignment: Alignment.center,
//         child: DropdownButtonFormField(
//           decoration: InputDecoration(
//               enabledBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Palette.primaryColor))),
//           onTap: readDeviceFunc,
//           dropdownColor: Palette.primaryColor,
//           onChanged: (value) {
//             setState(() {
//               selectedDeviceID = value;
//               sendDevice = value;
//             });
//           },
//           value: selectedDeviceID,
//           items: deviceID
//               .map((e) => DropdownMenuItem(
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           e,
//                           style: TextStyle(
//                               fontSize: 16.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         )
//                       ],
//                     ),
//                     value: e,
//                   ))
//               .toList(),
//         ),
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 150,
//             child: TextField(
//               controller: deviceController,
//               decoration: InputDecoration(),
//             ),
//           ),
//           IconButton(onPressed: addDevice, icon: Icon(Icons.add)),
//           IconButton(onPressed: delDevice, icon: Icon(Icons.remove)),
//         ],
//       ),
//     ]));
//   }
// }
