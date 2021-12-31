import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class TEMData {
  TEMData(this.contient, this.tem);

  final int contient;
  final double tem;
}

class SenBarChart extends StatefulWidget {
  final List<double> sensigDataDaily;

  const SenBarChart({@required this.sensigDataDaily});

  @override
  _SenBarChartState createState() => _SenBarChartState();
}

class _SenBarChartState extends State<SenBarChart> {
  List<TEMData> getChartData() {
    final List<TEMData> chartData = [
      TEMData(6, 20.6),
      TEMData(9, 22.7),
      TEMData(12, 22.9),
      TEMData(15, 25.8),
      TEMData(18, 29.1),
      TEMData(21, 27.8),
      TEMData(24, 23.1),
    ];
    return chartData;
  }

  List<TEMData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Daily data (Bar Data)",
              style:
                  const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: SfCartesianChart(
              series: <ChartSeries>[
                BarSeries<TEMData, int>(
                    dataSource: _chartData,
                    xValueMapper: (TEMData tem, _) => tem.contient,
                    yValueMapper: (TEMData tem, _) => tem.tem)
              ],
            ),
          )
        ],
      ),
    );
  }
}
