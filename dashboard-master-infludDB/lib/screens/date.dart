// ignore_for_file: deprecated_member_use, unnecessary_statements, missing_return

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm_dashboard/config/palette.dart';
import 'package:smartfarm_dashboard/config/styles.dart';
import 'package:smartfarm_dashboard/data/data.dart';
import 'package:smartfarm_dashboard/data/function.dart';
import 'package:smartfarm_dashboard/data/grpc.dart';
import 'package:smartfarm_dashboard/widgets/stats_grid.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DateScreen extends StatefulWidget {
  @override
  _DateScreenState createState() => _DateScreenState();
}

class _DateScreenState extends State<DateScreen> {
  int rate;

  var functionBox = FunctionBox();

  List<SalesData> _temChartData;
  List<SalesData> _humChartData;
  List<SalesData> _co2ChartData;
  List<SalesData> _nh3ChartData;
  List<SalesData> _luxChartData;

  void errorDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: new Text(
              "Error",
              style: TextStyle(fontSize: 20),
            )),
            content: SizedBox(
              height: 40,
              child: Center(
                  child: new Text(
                "\nList is empty",
                style: TextStyle(fontSize: 17),
              )),
            ),
            actions: <Widget>[
              new TextButton(
                  child: new Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
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

  var grpc = Grpc();

  bool temVisible = true;
  bool humVisible = false;
  bool co2Visible = false;
  bool nh3Visible = false;
  bool luxVisible = false;

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
              width: MediaQuery.of(context).size.width * 0.05,
              height: MediaQuery.of(context).size.height * 0.05,
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
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                    child: Column(
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.4,
                    //   child: RaisedButton(
                    //     color: Colors.lightBlue,
                    //     onPressed: fireStoreTest,
                    //     child: Text(
                    //       "Load Graph",
                    //       style: TextStyle(color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Palette.primaryColor,
        actions: <Widget>[
          Stack(
            children: [
              // Visibility(
              //     visible: visibilityMap[0],
              //     child: IconButton(
              //         onPressed: fireStoreTest, icon: Icon(Icons.refresh))),
            ],
          )
        ],
      ),
      body: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: <Widget>[
          _buildHeader(),
          _buildRegionTabBar(),
          _buildStatsTabBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: screenHeight * 0.6,
                      child: Stack(
                        children: [
                          Visibility(
                            visible: temVisible,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: "Temperature Bar Chart",
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                series: <ChartSeries>[
                                  BarSeries<SalesData, double>(
                                      name: "temperature",
                                      dataSource: _temChartData,
                                      xValueMapper: (SalesData sales, _) =>
                                          double.parse(sales.hour.toString()),
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.value,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                                primaryXAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: humVisible,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: "Humidity Bar Chart",
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                series: <ChartSeries>[
                                  BarSeries<SalesData, double>(
                                      name: "%",
                                      dataSource: _humChartData,
                                      xValueMapper: (SalesData sales, _) =>
                                          double.parse(sales.hour.toString()),
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.value,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                                primaryXAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: co2Visible,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: "Co2 Bar Chart",
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                series: <ChartSeries>[
                                  BarSeries<SalesData, double>(
                                      name: "ppm",
                                      dataSource: _co2ChartData,
                                      xValueMapper: (SalesData sales, _) =>
                                          double.parse(sales.hour.toString()),
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.value,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                                primaryXAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: nh3Visible,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: "NH3 Bar Chart",
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                series: <ChartSeries>[
                                  BarSeries<SalesData, double>(
                                      name: "NH3",
                                      dataSource: _nh3ChartData,
                                      xValueMapper: (SalesData sales, _) =>
                                          double.parse(sales.hour.toString()),
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.value,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                                primaryXAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: luxVisible,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              child: SfCartesianChart(
                                title: ChartTitle(
                                    text: "Lux Bar Chart",
                                    textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    )),
                                series: <ChartSeries>[
                                  BarSeries<SalesData, double>(
                                      name: "lx",
                                      dataSource: _luxChartData,
                                      xValueMapper: (SalesData sales, _) =>
                                          double.parse(sales.hour.toString()),
                                      yValueMapper: (SalesData sales, _) =>
                                          sales.value,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true))
                                ],
                                primaryXAxis: NumericAxis(
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'Cartesian Bar Chart'
          '',
          style: const TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 5,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: <Widget>[
              Text(
                "Tem",
                style: const TextStyle(fontSize: 14.8),
              ),
              Text("Hum"),
              Text("CO2"),
              Text("Amm"),
              Text("Lux"),
            ],
            onTap: (index) {
              if (index == 0) {
                setState(() {
                  temVisible = true;
                  humVisible = false;
                  co2Visible = false;
                  nh3Visible = false;
                  luxVisible = false;
                  statHolder = "Tem";
                });
              } else if (index == 1) {
                setState(() {
                  temVisible = false;
                  humVisible = true;
                  co2Visible = false;
                  nh3Visible = false;
                  luxVisible = false;
                  statHolder = "Hum";
                });
              } else if (index == 2) {
                setState(() {
                  temVisible = false;
                  humVisible = false;
                  co2Visible = true;
                  nh3Visible = false;
                  luxVisible = false;
                  statHolder = "Co2";
                });
              } else if (index == 3) {
                setState(() {
                  temVisible = false;
                  humVisible = false;
                  co2Visible = false;
                  nh3Visible = true;
                  luxVisible = false;
                  statHolder = "NH3";
                });
              } else if (index == 4) {
                setState(() {
                  temVisible = false;
                  humVisible = false;
                  co2Visible = false;
                  nh3Visible = false;
                  luxVisible = true;
                  statHolder = "LUX";
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
          ),
        ),
      ),
    );
  }
}
