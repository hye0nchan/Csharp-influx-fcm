import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:smartfarm_dashboard/network.pbgrpc.dart';
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
    stub = ExProtoClient(ClientChannel(fireStoreIp,
        port: 5054,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure())));
    await stub.exClientstream(box
      ..channel = 2000
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
      ..channel = 2000
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
      ..channel = 2000
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
      ..sensor = 4
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
      ..sensor = 5
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
      ..sensor = 6
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
      ..sensor = 7
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
      ..sensor = 8
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
      ..sensor = 9
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
      ..sensor = 10
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
      ..sensor = 11
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
      ..sensor = 12
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
      ..sensor = 13
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
      ..sensor = 14
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
      ..sensor = 15
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
      ..sensor = 16
      ..sensor = 0
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
