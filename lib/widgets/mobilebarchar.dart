import 'package:clima/appscolors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomMobileBarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  CustomMobileBarChart({Key? key}) : super(key: key);

  @override
  _CustomMobileBarChartPageState createState() =>
      _CustomMobileBarChartPageState();
}

class _CustomMobileBarChartPageState extends State<CustomMobileBarChart> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData(
          DateFormat('E').format(
            DateTime.now().add(Duration(days: 3)),
          ),
          37.0),
      _ChartData(
          DateFormat('E').format(
            DateTime.now().add(Duration(days: 2)),
          ),
          25.0),
      _ChartData("Tomorrow", 50.0),
      _ChartData("Today", 27.0),
      _ChartData("Yesterday", 23.0),
      _ChartData(
          DateFormat('E').format(
            DateTime.now().add(Duration(days: -2)),
          ),
          25.0),
      _ChartData(
          DateFormat('E').format(
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
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 8, right: 8, left: 8),
      child: SfCartesianChart(
        isTransposed: true,
        enableAxisAnimation: true,
        title: ChartTitle(
            text: temaqi ? 'Air Quality' : 'Temperature',
            textStyle: GoogleFonts.mada(shadows: [
              Shadow(
                blurRadius: 10.0,
                color: const Color.fromARGB(255, 0, 0, 0),
                offset: Offset(5.0, 5.0),
              ),
            ], color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500)),
        primaryXAxis: CategoryAxis(
            labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            axisLine: AxisLine(color: Colors.white)),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 60,
          interval: 5,
          axisLine: AxisLine(
            color: Color.fromARGB(
                255, 255, 255, 255), // Change axis line color to white
          ),
          majorTickLines: MajorTickLines(
            color: Color.fromARGB(
                255, 255, 255, 255), // Change major tick line color to white
          ),
          labelStyle: TextStyle(
              color: Color.fromARGB(
                  255, 255, 255, 255)), // Change labels color to white
        ),
        tooltipBehavior: _tooltip,
        series: <CartesianSeries<_ChartData, String>>[
          BarSeries<_ChartData, String>(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              animationDelay: 4000,
              borderColor: const Color.fromARGB(255, 255, 255, 255),
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Temperature',
              pointColorMapper: (_ChartData data, _) => getBarColor(data.y),
              color: Colors.deepPurpleAccent)
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
