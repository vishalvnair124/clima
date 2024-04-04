// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:clima/colorandvalue.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NoAnalysis extends StatefulWidget {
  DateTime date;
  NoAnalysis({Key? key, required this.date}) : super(key: key);
  @override
  State<NoAnalysis> createState() => _NoAnalysisState();
}

class _NoAnalysisState extends State<NoAnalysis> {
  late DateTime selectedDate;
  late List<_ChartData> data = [];
  late List<double> x = List<double>.filled(12, 0.0);
  late TooltipBehavior _tooltip;

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
  void didUpdateWidget(NoAnalysis oldWidget) {
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
                text: 'NO2',
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
                maximum: 15,
                interval: 1,
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
                  name: "NO2",
                  pointColorMapper: (_ChartData data, _) =>
                      getColorAndSituationForNO2(data.y)['color'],
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
      //print(selectedDate);
      var uri =
          'http://10.0.2.2:8000/hourly_weather/${DateFormat('yyyy-MM-dd').format(selectedDate)}';

      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (this.mounted && response.statusCode == 200) {
        var responseData = response.body;
        var decodeData = json.decode(responseData);
        //print(decodeData);

        setState(() {
          x[0] = decodeData['0']['NO2_Level'].toDouble();
          x[1] = decodeData['2']['NO2_Level'].toDouble();
          x[2] = decodeData['4']['NO2_Level'].toDouble();
          x[3] = decodeData['6']['NO2_Level'].toDouble();
          x[4] = decodeData['8']['NO2_Level'].toDouble();
          x[5] = decodeData['10']['NO2_Level'].toDouble();
          x[6] = decodeData['12']['NO2_Level'].toDouble();
          x[7] = decodeData['14']['NO2_Level'].toDouble();
          x[8] = decodeData['16']['NO2_Level'].toDouble();
          x[9] = decodeData['18']['NO2_Level'].toDouble();
          x[10] = decodeData['20']['NO2_Level'].toDouble();
          x[11] = decodeData['22']['NO2_Level'].toDouble();

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
