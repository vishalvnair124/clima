// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AqiAnalysis extends StatefulWidget {
  DateTime date;
  AqiAnalysis({Key? key, required this.date}) : super(key: key);
  @override
  State<AqiAnalysis> createState() => _AqiAnalysisState();
}

class _AqiAnalysisState extends State<AqiAnalysis> {
  late DateTime selectedDate;
  late List<_ChartData> data = [];
  late List<double> x = List<double>.filled(12, 0.0);
  late TooltipBehavior _tooltip;

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
  void initState() {
    super.initState();
    selectedDate = widget.date;
    _tooltip = TooltipBehavior(
      textStyle: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),
      enable: true,
      color: Color.fromARGB(255, 255, 255, 255),
    );

    getWeather();
  }

  @override
  void didUpdateWidget(AqiAnalysis oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Fetch weather data whenever the widget is updated with a new date
    if (oldWidget.date != widget.date) {
      getWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 7.0,
                color: const Color.fromARGB(255, 0, 0, 0),
                offset: Offset(2.0, 2.0),
              )
            ],
            borderRadius: BorderRadius.circular(35),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/ForestBG-body.png'),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
              bottom: 8,
              right: 8,
              left: 8,
            ),
            child: SfCartesianChart(
              isTransposed: true,
              enableAxisAnimation: true,
              title: ChartTitle(
                text: 'AQI',
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(color: Colors.white),
                axisLine: AxisLine(color: Colors.white),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 60,
                interval: 5,
                axisLine: AxisLine(color: Colors.white),
                majorTickLines: MajorTickLines(color: Colors.white),
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
                  name: "AQI",
                  pointColorMapper: (_ChartData data, _) => getBarColor(data.y),
                  color: Colors.deepPurpleAccent,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getWeather() async {
    var client = http.Client();
    try {
      x = List<double>.filled(12, 0.0);
      print(selectedDate);
      var uri =
          'http://10.0.2.2:8000/hourly_weather/${DateFormat('yyyy-MM-dd').format(selectedDate)}';

      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var responseData = response.body;
        var decodeData = json.decode(responseData);
        print(decodeData);

        setState(() {
          x[0] = decodeData['0']['Air_Quality_Index'].toDouble();
          x[1] = decodeData['2']['Air_Quality_Index'].toDouble();
          x[2] = decodeData['4']['Air_Quality_Index'].toDouble();
          x[3] = decodeData['6']['Air_Quality_Index'].toDouble();
          x[4] = decodeData['8']['Air_Quality_Index'].toDouble();
          x[5] = decodeData['10']['Air_Quality_Index'].toDouble();
          x[6] = decodeData['12']['Air_Quality_Index'].toDouble();
          x[7] = decodeData['14']['Air_Quality_Index'].toDouble();
          x[8] = decodeData['16']['Air_Quality_Index'].toDouble();
          x[9] = decodeData['18']['Air_Quality_Index'].toDouble();
          x[10] = decodeData['20']['Air_Quality_Index'].toDouble();
          x[11] = decodeData['22']['Air_Quality_Index'].toDouble();

          data = [
            _ChartData("12am", x[0]),
            _ChartData("2am", x[1]),
            _ChartData("4am", x[2]),
            _ChartData("6am", x[3]),
            _ChartData("8am", x[4]),
            _ChartData("10am", x[5]),
            _ChartData("12n", x[6]),
            _ChartData("2pm", x[7]),
            _ChartData("4pm", x[8]),
            _ChartData("6pm", x[9]),
            _ChartData("8pm", x[10]),
            _ChartData("10pm", x[11]),
          ];
        });
      } else {
        print('Request failed with status  eee: ${response.statusCode}');
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
