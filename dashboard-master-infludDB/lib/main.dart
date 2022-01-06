// ignore_for_file: unnecessary_statements, must_be_immutable

//c# client 완성
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:ntp/ntp.dart';
import 'package:smartfarm_dashboard/network.pb.dart';
import 'package:smartfarm_dashboard/screens/bottom_nav_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'data/data.dart';
import 'network.pbgrpc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  var home = MyApp();
}

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Dashboard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            scaffoldBackgroundColor: Colors.white),
        home: AnimatedSplashScreen(
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('imgs/logo.gif'),
              Text(
                "SALTANB\nSMART FARM",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              )
            ],
          ),
          nextScreen: BottomNavScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.white,
          duration: 3000,
        ));
  }

  String data;

  String gateway;

  var ro;

  var de = Int64.parseRadix('21A106057F68D', 16);

  var gw;

  var sequenceNumber;

  var channel;

  List<int> da;

  var request = RtuMessage();

  var response;

  final fireStore = FirebaseFirestore.instance;

  var device;

  Future<ExMessage> receiveMessage() async {
    print("receive");
    ExProtoClient stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    await for (response in stub.exServerstream(request)) {
      da = response.dataUnit;
      de = response.deviceId;
      gw = response.gwId;
      sequenceNumber = response.sequenceNumber;
      if (de == 0x24A16057F685) {
        device = de;
      } else if (de == 0x500291AEBCD9) {
        device = de;
      } else {
        device = de;
      }
      print(device);
      channel == 2000 ? displaySensorData(da, device) : null;
    }

    return response;
  }

  void displaySensorData(List<int> receiveData, Int64 device) {
    print(device);
    (isCheckedMap[0]) ? displayTemData(da, device) : null;
    (isCheckedMap[1]) ? displayHumData(da, device) : null;
    (isCheckedMap[2]) ? displayCo2Data(da, device) : null;
    (isCheckedMap[3]) ? displayLuxData(da, device) : null;
    (isCheckedMap[4]) ? displayUvData(da, device) : null;
    (isCheckedMap[5]) ? displayNh3Data(da, device) : null;
    (isCheckedMap[6]) ? displayNh3LData(da, device) : null;
    (isCheckedMap[7]) ? displayNh3MData(da, device) : null;
    (isCheckedMap[8]) ? displayNh3HData(da, device) : null;
    (isCheckedMap[9]) ? displayNo2Data(da, device) : null;
    (isCheckedMap[10]) ? displayNo2LData(da, device) : null;
    (isCheckedMap[11]) ? displayNo2MData(da, device) : null;
    (isCheckedMap[12]) ? displayNo2HData(da, device) : null;
    (isCheckedMap[13]) ? displayCoData(da, device) : null;
    (isCheckedMap[14]) ? displayCoLData(da, device) : null;
    (isCheckedMap[15]) ? displayCoMData(da, device) : null;
    (isCheckedMap[16]) ? displayCoHData(da, device) : null;
  }

  void displayTemData(List<int> receiveData, Int64 device) {
    var sensor = "tem";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[temList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    print(bData);
    discernDevice(device, sensor, bData);
  }

  void displayHumData(List<int> receiveData, Int64 device) {
    var sensor = "hum";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[humList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayCo2Data(List<int> receiveData, Int64 device) {
    var sensor = "co2";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[co2List[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayLuxData(List<int> receiveData, Int64 device) {
    var sensor = "lux";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[luxList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayUvData(List<int> receiveData, Int64 device) {
    var sensor = "uv";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[uvList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNh3Data(List<int> receiveData, Int64 device) {
    var sensor = "nh3";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[nh3List[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNh3LData(List<int> receiveData, Int64 device) {
    var sensor = "nh3L";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[nh3LList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNh3MData(List<int> receiveData, Int64 device) {
    var sensor = "nh3M";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[nh3MList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNh3HData(List<int> receiveData, Int64 device) {
    var sensor = "nh3H";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[nh3HList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNo2Data(List<int> receiveData, Int64 device) {
    var sensor = "no2";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[no2List[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNo2LData(List<int> receiveData, Int64 device) {
    var sensor = "no2L";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[no2LList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNo2MData(List<int> receiveData, Int64 device) {
    var sensor = "no2M";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[no2MList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayNo2HData(List<int> receiveData, Int64 device) {
    var sensor = "no2H";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[no2HList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayCoData(List<int> receiveData, Int64 device) {
    var sensor = "co";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[coList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayCoLData(List<int> receiveData, Int64 device) {
    var sensor = "coL";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[coLList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayCoMData(List<int> receiveData, Int64 device) {
    var sensor = "coM";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[coMList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void displayCoHData(List<int> receiveData, Int64 device) {
    var sensor = "coH";
    var bData = ByteData(4);
    List<int> intList = [0, 0, 0, 0];
    List<String> stringList = ["0", "0", "0", "0"];

    for (int i = 0; i < intList.length; i++) {
      intList[i] = receiveData[coHList[i]];
      stringList[i] = intList[i].toRadixString(16);
      if (stringList[i].length == 1) {
        stringList[i] = "0${stringList[i]}";
      }
      if (i == 0) {
        stringList[i] = "0x${intList[i].toRadixString(16)}";
      }
    }
    String total =
        "${stringList[0]}${stringList[1]}${stringList[2]}${stringList[3]}";
    int a = int.parse(total);
    bData.setInt32(0, a);
    discernDevice(device, sensor, bData);
  }

  void discernDevice(var device, var sensor, var bData) {
    switch (sensor) {
      case "tem":
        if (device == 0x24A16057F685) {
          sensor1Device = !sensor1Device;
          sensor1redTemData = bData.getFloat32(0).toStringAsFixed(2);
          print("sensor1 enter");
        } else if (device == 0x500291AEBCD9) {
          sensor2Device = !sensor2Device;
          sensor2redTemData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3Device = !sensor3Device;
          sensor3redTemData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "hum":
        if (device == 0x24A16057F685) {
          sensor1redHumData = bData.getFloat32(0).toStringAsFixed(2);
          print("hum : $sensor1redHumData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redHumData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redHumData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "co2":
        if (device == 0x24A16057F685) {
          sensor1redCo2Data = bData.getFloat32(0).toStringAsFixed(2);
          print("co2 : $sensor1redCo2Data");
        } else if (device == 0x500291AEBCD9) {
          sensor2redCo2Data = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redCo2Data = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "nh3":
        if (device == 0x24A16057F685) {
          sensor1redNh3Data = bData.getFloat32(0).toStringAsFixed(2);
          print("nh3 : $sensor1redNh3Data");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNh3Data = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNh3Data = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "nh3L":
        if (device == 0x24A16057F685) {
          sensor1redNh3LData = bData.getFloat32(0).toStringAsFixed(2);
          print("nh3L : $sensor1redNh3LData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNh3LData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNh3LData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "nh3M":
        if (device == 0x24A16057F685) {
          sensor1redNh3MData = bData.getFloat32(0).toStringAsFixed(2);
          print("nh3M : $sensor1redNh3MData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNh3MData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNh3MData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "nh3H":
        if (device == 0x24A16057F685) {
          sensor1redNh3HData = bData.getFloat32(0).toStringAsFixed(2);
          print("nh3H : $sensor1redNh3HData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNh3HData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNh3HData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "uv":
        if (device == 0x24A16057F685) {
          sensor1redUvData = bData.getFloat32(0).toStringAsFixed(2);
          print("uv : $sensor1redUvData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redUvData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redUvData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "lux":
        if (device == 0x24A16057F685) {
          sensor1redLuxData = bData.getFloat32(0).toStringAsFixed(2);
          print("lux : $sensor1redLuxData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redLuxData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redLuxData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "no2":
        if (device == 0x24A16057F685) {
          sensor1redNo2Data = bData.getFloat32(0).toStringAsFixed(2);
          print("no2 : $sensor1redNo2Data");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNo2Data = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNo2Data = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "no2L":
        if (device == 0x24A16057F685) {
          sensor1redNo2LData = bData.getFloat32(0).toStringAsFixed(2);
          print("no2L : $sensor1redNo2LData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNo2LData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNo2LData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "no2M":
        if (device == 0x24A16057F685) {
          sensor1redNo2MData = bData.getFloat32(0).toStringAsFixed(2);
          print("no2M : $sensor1redNo2MData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNo2MData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNo2MData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "no2H":
        if (device == 0x24A16057F685) {
          sensor1redNo2HData = bData.getFloat32(0).toStringAsFixed(2);
          print("no2H : $sensor1redNo2HData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redNo2HData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redNo2HData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "co":
        if (device == 0x24A16057F685) {
          sensor1redCoData = bData.getFloat32(0).toStringAsFixed(2);
          print("co : $sensor1redCoData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redCoData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redCoData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "coL":
        if (device == 0x24A16057F685) {
          sensor1redCoLData = bData.getFloat32(0).toStringAsFixed(2);
          print("coL : $sensor1redCoLData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redCoLData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redCoLData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "coM":
        if (device == 0x24A16057F685) {
          sensor1redCoMData = bData.getFloat32(0).toStringAsFixed(2);
          print("coM : $sensor1redCoMData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redCoMData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redCoMData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
      case "coH":
        if (device == 0x24A16057F685) {
          sensor1redCoHData = bData.getFloat32(0).toStringAsFixed(2);
          print("coH : $sensor1redCoHData");
        } else if (device == 0x500291AEBCD9) {
          sensor2redCoHData = bData.getFloat32(0).toStringAsFixed(2);
        } else {
          sensor3redCoHData = bData.getFloat32(0).toStringAsFixed(2);
        }
        break;
    }
    sensor1Device = false;
    sensor2Device = false;
    sensor3Device = false;
  }
}
