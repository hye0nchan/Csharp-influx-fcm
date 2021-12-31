// ignore_for_file: unnecessary_statements, missing_return
//grafana 설치
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm_dashboard/config/palette.dart';
import 'package:smartfarm_dashboard/config/styles.dart';
import 'package:smartfarm_dashboard/data/data.dart';
import 'package:smartfarm_dashboard/data/function.dart';
import 'package:smartfarm_dashboard/data/grpc.dart';
import 'package:smartfarm_dashboard/widgets/stats_grid.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  var functionBox = FunctionBox();
  int rate;
  bool switchValue = false;

  ZoomPanBehavior _zoomPanBehavior =
  ZoomPanBehavior(enablePinching: true, enableDoubleTapZooming: true);

  //센서1

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    functionBox.changeVisibilityStatScreenLists(0);
    super.initState();
  }



  void loadingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context);
          });
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Center(
                child: new Text(
                  "Loading Data",
                  style: TextStyle(fontSize: 20),
                )),
            content: SizedBox(
              height: 60,
              child: Column(
                children: [
                  Center(
                    child: new CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation(Colors.blue),
                        strokeWidth: 5.0),
                  ),
                  Text(
                    "Click again",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          );
        });
  }

  void readInfluxDB() async {
    for (int i = 0; i < allSensorList.length; i++) {
      var sensorStream = await queryService.query('''
  from(bucket: "farmcare")
  |> range(start: -1h)
  |> filter(fn: (r) => r["_measurement"] == "${allSensorList[i]}")
  |> yield(name: "mean")
  ''');
      await sensorStream.forEach((record) {
        DateTime date = DateTime.parse(record['_time']);
        var value = record['_value'];
        setState(() {
          if (!sensorChartData[i].contains(ChartData(date, value))) {
            sensorChartData[i].add(ChartData(date, value));
          }
        });
      });
    }
  }

  var grpc = Grpc();

  bool barChartVisible = false;
  bool chartVisible = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Palette.primaryColor,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                print(sensor1redTemData);
                readInfluxDB();
              },
              icon: Icon(Icons.menu))
        ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(screenHeight),
          _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: screenHeight * 0.6,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      child: Stack(
                        children: [
                          //test
                          Visibility(
                            visible: visibilityStatScreenMap[0],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "Temperature Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: tem1ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: tem2ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: tem3ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibilityStatScreenMap[1],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "Humidity Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "%",
                                    dataSource: hum1ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "%",
                                    dataSource: hum2ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "%",
                                    dataSource: hum3ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibilityStatScreenMap[2],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "Co2 Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "ppm",
                                    dataSource: co21ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "ppm",
                                    dataSource: co22ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "ppm",
                                    dataSource: co23ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibilityStatScreenMap[3],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "Lux Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: lux1ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: lux2ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: lux3ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibilityStatScreenMap[4],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "Uv Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: uv1ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: uv2ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: uv3ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibilityStatScreenMap[5],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "Ammonia Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: nh31ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: nh32ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: nh33ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibilityStatScreenMap[6],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "No2 Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: no21ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: no22ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: no23ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: visibilityStatScreenMap[7],
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                zoomPanBehavior: _zoomPanBehavior,
                                primaryXAxis: DateTimeAxis(
                                    minimum: firstDate,
                                    maximum: currentDate,
                                    intervalType: DateTimeIntervalType.hours,
                                    interval: 1),
                                title: ChartTitle(
                                  text: "Co Chart",
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                ),
                                series: <ChartSeries<ChartData, DateTime>>[
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: co1ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: co2ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                  LineSeries<ChartData, DateTime>(
                                    name: "℃",
                                    dataSource: co3ChartData,
                                    xValueMapper: (ChartData sales, _) =>
                                    sales.time,
                                    yValueMapper: (ChartData sales, _) =>
                                    sales.value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Cartesian Chart',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  "Recent Data",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                    height: 10,
                    child: Switch(
                        value: switchValue,
                        onChanged: (value) {
                          setState(() {
                            switchValue = !switchValue;
                          });
                        }))
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar(double screenHeight) {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 8,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: screenHeight * 0.055,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 45.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Center(
                  child: Text(
                    "T\ne\nm",
                  )),
              Center(
                  child: Text(
                    "H\nu\nm",
                  )),
              Center(
                  child: Text(
                    "C\nO\n2",
                  )),
              Center(
                  child: Text(
                    "L\nu\nx",
                  )),
              Center(
                  child: Text(
                    "U\nv",
                  )),
              Center(
                  child: Text(
                    "A\nm\nm",
                  )),
              Center(
                  child: Text(
                    "N\no\n2",
                  )),
              Center(
                  child: Text(
                    "C\no",
                  )),
            ],
            onTap: (index) {
              if (index == 0) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(0);
                  statHolder = "Tem";
                });
              } else if (index == 1) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(1);
                  statHolder = "Hum";
                });
              } else if (index == 2) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(2);
                  statHolder = "Co2";
                });
              } else if (index == 3) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(3);
                  statHolder = "Lux";
                });
              } else if (index == 4) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(4);
                  statHolder = "Uv";
                });
              } else if (index == 5) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(5);
                  statHolder = "Amm";
                });
              } else if (index == 6) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(6);
                  statHolder = "No2";
                });
              } else if (index == 7) {
                setState(() {
                  functionBox.changeVisibilityStatScreenLists(7);
                  statHolder = "Co";
                });
              }
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 5,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: <Widget>[
              Text(
                "1 HOUR",
                textAlign: TextAlign.center,
              ),
              Text(
                "3 HOUR",
                textAlign: TextAlign.center,
              ),
              Text(
                "12 HOUR",
                textAlign: TextAlign.center,
              ),
              Text(
                "1\nDAY",
                textAlign: TextAlign.center,
              ),
              Text(
                "2 DAYS",
                textAlign: TextAlign.center,
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                rate = 1;
              } else if (index == 1) {
                rate = 3;
              } else if (index == 2) {
                rate = 12;
              } else if (index == 3) {
                rate = 24;
              } else if (index == 4) {
                rate = 48;
              }
            },
          ),
        ),
      ),
    );
  }

  void showMenu() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Close",
                  style: TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
            title: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.05,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Palette.primaryColor,
              ),
              child: Center(
                child: Text(
                  "Graph Setting",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17),
                ),
              ),
            ),
            content: SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                child: Center(
                    child: Column(
                      children: [
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.4,
                        //   child: RaisedButton(
                        //     color: Colors.lightBlue,
                        //     onPressed: fireStoreTest,
                        //     child: Stack(
                        //       children: [
                        //         Visibility(
                        //           visible: loadingCount,
                        //           child: Text(
                        //             "Connecting Server",
                        //             style: TextStyle(color: Colors.white),
                        //             //Timer.period
                        //           ),
                        //         ),
                        //         Visibility(
                        //           visible: !loadingCount,
                        //           child: Text(
                        //             "Load Grapgh",
                        //             style: TextStyle(color: Colors.white),
                        //             //Timer.period
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ))),
          );
        });
      },
    );
  }
}
