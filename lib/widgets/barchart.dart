import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomBarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomBarChart({Key? key}) : super(key: key);

  @override
  _CustomBarChartPageState createState() => _CustomBarChartPageState();
}

class _CustomBarChartPageState extends State<CustomBarChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData(
          DateFormat('EEEE').format(
            DateTime.now().add(Duration(days: 3)),
          ),
          37.0),
      _ChartData(
          DateFormat('EEEE').format(
            DateTime.now().add(Duration(days: 2)),
          ),
          25.0),
      _ChartData("Tomorrow", 50.0),
      _ChartData("Today", 27.0),
      _ChartData("Yesterday", 23.0),
      _ChartData(
          DateFormat('EEEE').format(
            DateTime.now().add(Duration(days: -2)),
          ),
          25.0),
      _ChartData(
          DateFormat('EEEE').format(
            DateTime.now().add(Duration(days: -3)),
          ),
          33.0),
    ];

    _tooltip = TooltipBehavior(
        textStyle: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),
        enable: true,
        color: Color.fromARGB(255, 255, 255, 255));
    super.initState();
  }

  Color getBarColor(double value) {
    if (value < 30.0) {
      return Colors.green;
    } else if (value < 35.0) {
      return Colors.yellow;
    } else if (value < 40.0) {
      return Color.fromARGB(255, 235, 136, 16);
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(
          labelStyle: TextStyle(color: Colors.white),
          axisLine: AxisLine(color: Colors.white)),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 60,
        interval: 5,
        axisLine: AxisLine(
          color: Colors.white, // Change axis line color to white
        ),
        majorTickLines: MajorTickLines(
          color: Colors.white, // Change major tick line color to white
        ),
        labelStyle:
            TextStyle(color: Colors.white), // Change labels color to white
      ),
      tooltipBehavior: _tooltip,
      series: <CartesianSeries<_ChartData, String>>[
        BarSeries<_ChartData, String>(
            animationDelay: 4000,
            borderColor: const Color.fromARGB(255, 255, 255, 255),
            dataSource: data,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            name: 'Temperature',
            pointColorMapper: (_ChartData data, _) => getBarColor(data.y),
            borderRadius:
                BorderRadius.horizontal(right: Radius.elliptical(15, 15)),
            color: Colors.deepPurpleAccent)
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
