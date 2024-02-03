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

    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  Color getBarColor(double value) {
    if (value < 30.0) {
      return Colors.green;
    } else if (value < 40.0) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      enableAxisAnimation: true,
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 60, interval: 5),
      tooltipBehavior: _tooltip,
      series: <CartesianSeries<_ChartData, String>>[
        BarSeries<_ChartData, String>(
          dataSource: data,
          xValueMapper: (_ChartData data, _) => data.x,
          yValueMapper: (_ChartData data, _) => data.y,
          name: 'Temperature',
          pointColorMapper: (_ChartData data, _) => getBarColor(data.y),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
