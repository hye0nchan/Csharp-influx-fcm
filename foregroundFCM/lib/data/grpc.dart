// ignore_for_file: unnecessary_statements

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:fcm_notifications/network.pbgrpc.dart';
import 'data.dart';

class Grpc {
  //전송 레지스터 값

  // 0x24A16057F685
  // 1번 : 습도 / 00CB
  // 4번 : 온도 / 00D4
  // 5번 : 이산화탄소 / 00D7
  // 6번 : 조도 / 00DA
  // 7번 : 자외선 / 00DD
  // 8번 : 암모니아 / 00E0
  // 9번 : 이산화질소 / 00e3
  // 10번 : 일산화탄소 / 00E6
  // 11번 : 암모니아센서_L / 00E9
  // 12번 : 암모니아센서_M / 00EC
  // 13번 : 암모니아센서_H / 00EF
  // 16 : 이산화질소센서_L / 00F8
  // 18 : 이산화질소센서_M / 00fe
  // 19 : 이산화질소센서_H / FF02
  // 22 : 일산화탄소_L / FF0B
  // 23 : 일산화탄소_M / FF0E
  // 24 : 일산화탄소_H / FF11

  //1번 주소 0x24A16057F685
  //2번 주소 0x500291AEBCD9
  //3번 주소 0x500291AEBE4D

  List<int> sensorResiter = [0x01, 0x03, 0xCB, 0x52];
  List<int> temResiter = [0x01, 0x03, 0xD4, 0x04];
  List<int> humResiter = [0x01, 0x03, 0xCB, 0x04];
  List<int> co2Resiter = [0x01, 0x03, 0xD7, 0x04];
  List<int> luxResiter = [0x01, 0x03, 0xDA, 0x04];
  List<int> uvResiter = [0x01, 0x03, 0xDD, 0x04];
  List<int> nh3Resiter = [0x01, 0x03, 0xE0, 0x04];
  List<int> nh3LResiter = [0x01, 0x03, 0xE9, 0x04];
  List<int> nh3MResiter = [0x01, 0x03, 0xEC, 0x04];
  List<int> nh3HResiter = [0x01, 0x03, 0xEF, 0x04];
  List<int> no2Resiter = [0x01, 0x03, 0xE3, 0x04];
  List<int> no2LResiter = [0x01, 0x03, 0xF8, 0x04];
  List<int> no2MResiter = [0x01, 0x03, 0xfe, 0x04];
  List<int> no2HResiter = [0x01, 0x03, 0x02, 0x04];
  List<int> coResiter = [0x01, 0x03, 0xE6, 0x04];
  List<int> coLResiter = [0x01, 0x03, 0x0B, 0x04];
  List<int> coMResiter = [0x01, 0x03, 0x0E, 0x04];
  List<int> coHResiter = [0x01, 0x03, 0x11, 0x04];

  //fireStore 선언
  final fireStore = FirebaseFirestore.instance;

  //IP 가져오기
  void getIp() {
    fireStore.collection("IP").get().then((QuerySnapshot ds) {
      ds.docs.forEach((doc) {
        fireStoreIp = doc["IP"];
      });
      print("test1$fireStoreIp");
    });
    print("out loop$fireStoreIp");
    fireStoreIp = inputText;
  }

  //DeviceId, Gateway 변수 선언

  //DeviceId Int64로 형변형
  void deviceSubmitted() {
    stringDevice = "0x" + "500291AEBCD9";
    String intDevice = int.parse(stringDevice).toString();
    hexDevice = Int64.parseInt(intDevice);
    sendDeviceId = hexDevice;
  }

  ExProtoClient stub;

  //현재 값 0임
  var ga1 = 0;

  void gatewaySubmitted() {
    stringGateway = "0x" + selectedGateway;
    hexGateway = int.parse(stringGateway);
    //sendGateway = hexGateway;
    sendGateway = 0;
  }

  final box = new RtuMessage();

  Future<RtuMessage> sendSensor1() async {
    var protocol = 200;
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    await stub.exClientstream(box
      ..channel = protocol
      ..sequenceNumber = 0
      ..gwId = 0
      ..dataUnit = [
        sensorResiter[0],
        sensorResiter[1],
        0x00,
        sensorResiter[2],
        0x00,
        sensorResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = de1);
    return (box);
  }

  Future<RtuMessage> sendSensor2() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    await stub.exClientstream(box
      ..channel = 200
      ..sequenceNumber = 0
      ..gwId = 0
      ..dataUnit = [
        sensorResiter[0],
        sensorResiter[1],
        0x00,
        sensorResiter[2],
        0x00,
        sensorResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = de2);
    return (box);
  }

  Future<RtuMessage> sendSensor3() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    await stub.exClientstream(box
      ..channel = 200
      ..sequenceNumber = 0
      ..gwId = 0
      ..dataUnit = [
        sensorResiter[0],
        sensorResiter[1],
        0x00,
        sensorResiter[2],
        0x00,
        sensorResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = de3);
    return (box);
  }

  String data;
  String gateway;
  var ro;
  var de = Int64.parseRadix('21A106057F68D', 16);
  var gw;
  var sequenceNumber;
  var grpcChannel;
  List<int> da;
  var request = RtuMessage();
  var response;
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
      if (de == 0x24A16057F685) {
        device = de;
      } else if (de == 0x500291AEBCD9) {
        device = de;
      } else {
        device = de;
      }
      displaySensorData(da, device);
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




    Future<RtuMessage> sendTemperature() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..channel = 0
      ..sequenceNumber = 0
      ..gwId = 0
      ..dataUnit = [
        temResiter[0],
        temResiter[1],
        0x00,
        temResiter[2],
        0x00,
        temResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendHumidity() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..sequenceNumber = 1
      ..gwId = ga1
      ..dataUnit = [
        humResiter[0],
        humResiter[1],
        0x00,
        humResiter[2],
        0x00,
        humResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendCo2() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..sequenceNumber = 2
      ..gwId = ga1
      ..dataUnit = [
        co2Resiter[0],
        co2Resiter[1],
        0x00,
        co2Resiter[2],
        0x00,
        co2Resiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendLux() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..sequenceNumber = 3
      ..gwId = ga1
      ..dataUnit = [
        luxResiter[0],
        luxResiter[1],
        0x00,
        luxResiter[2],
        0x00,
        luxResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendUv() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        uvResiter[0],
        uvResiter[1],
        0x00,
        uvResiter[2],
        0x00,
        uvResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNh3() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        nh3Resiter[0],
        nh3Resiter[1],
        0x00,
        nh3Resiter[2],
        0x00,
        nh3Resiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNh3L() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        nh3LResiter[0],
        nh3LResiter[1],
        0x00,
        nh3LResiter[2],
        0x00,
        nh3LResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNh3M() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        nh3MResiter[0],
        nh3MResiter[1],
        0x00,
        nh3MResiter[2],
        0x00,
        nh3MResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNh3H() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        nh3HResiter[0],
        nh3HResiter[1],
        0x00,
        nh3HResiter[2],
        0x00,
        nh3HResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNo2() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        no2Resiter[0],
        no2Resiter[1],
        0x00,
        no2Resiter[2],
        0x00,
        no2Resiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNo2L() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        no2LResiter[0],
        no2LResiter[1],
        0x00,
        no2LResiter[2],
        0x00,
        no2LResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNo2M() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        no2MResiter[0],
        no2MResiter[1],
        0x00,
        no2MResiter[2],
        0x00,
        no2MResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendNo2H() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        no2HResiter[0],
        no2HResiter[1],
        0x00,
        no2HResiter[2],
        0x00,
        no2HResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendCo() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        coResiter[0],
        coResiter[1],
        0x00,
        coResiter[2],
        0x00,
        coResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendCoL() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        coLResiter[0],
        coLResiter[1],
        0x00,
        coLResiter[2],
        0x00,
        coLResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendCoM() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        coMResiter[0],
        coMResiter[1],
        0x00,
        coMResiter[2],
        0x00,
        coMResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }

  Future<RtuMessage> sendCoH() async {
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    deviceSubmitted();
    await stub.exClientstream(box
      ..gwId = ga1
      ..dataUnit = [
        coHResiter[0],
        coHResiter[1],
        0x00,
        coHResiter[2],
        0x00,
        coHResiter[3],
        0xAD,
        0xDE
      ]
      ..deviceId = sendDeviceId);
    return (box);
  }
}
