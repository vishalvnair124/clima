import 'package:clima/colorandvalue.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CustomMobileBarChart extends StatefulWidget {
  const CustomMobileBarChart({Key? key}) : super(key: key);

  @override
  _CustomMobileBarChartPageState createState() =>
      _CustomMobileBarChartPageState();
}

class _CustomMobileBarChartPageState extends State<CustomMobileBarChart> {
  late List<_ChartData> data = [];

  late TooltipBehavior _tooltip;

  double a = 0.0, b = 0.0, c = 0.0;
  double today = 0.0;
  double e = 0.0, d = 0.0, f = 0.0;

  @override
  void initState() {
    super.initState();
    _tooltip = TooltipBehavior(
        textStyle: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),
        enable: true,
        color: Color.fromARGB(255, 255, 255, 255));
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 8, right: 8, left: 8),
      child: SfCartesianChart(
        isTransposed: true,
        enableAxisAnimation: true,
        title: ChartTitle(
            text: 'Temperature',
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500)),
        primaryXAxis: CategoryAxis(
            labelStyle: TextStyle(color: Colors.white),
            axisLine: AxisLine(color: Colors.white)),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 60,
          interval: 5,
          axisLine: AxisLine(
            color: Colors.white,
          ),
          majorTickLines: MajorTickLines(
            color: Colors.white,
          ),
          labelStyle: TextStyle(color: Colors.white),
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
              pointColorMapper: (_ChartData data, _) =>
                  getColorAndSituationForTemperature(data.y)['color'],
              color: Colors.deepPurpleAccent)
        ],
      ),
    );
  }

  void getWeather() async {
    var client = http.Client();
    try {
      var uri = 'http://10.0.2.2:8000/thisweektemp';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var responseData = response.body;
        var decodeData = json.decode(responseData);
        print(decodeData);
        setState(() {
          today = decodeData['Today_Temperature'] ?? 0.0;
          a = decodeData['Temperature']['7'];
          b = decodeData['Temperature']['8'];
          c = decodeData['Temperature']['9'];
          d = decodeData['Temperature']['10'];
          e = decodeData['Temperature']['11'];
          f = decodeData['Temperature']['12'];

          data = [
            _ChartData("Today", today),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 1)),
                ),
                a),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 2)),
                ),
                b),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 3)),
                ),
                c),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 4)),
                ),
                d),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 5)),
                ),
                e),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 6)),
                ),
                f),
          ];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather: $e');
    } finally {
      client.close();
    }
  }
}

class _ChartData {
  final String x;
  final double y;

  _ChartData(this.x, this.y);
}
