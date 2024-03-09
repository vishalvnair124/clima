import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PmForecast extends StatefulWidget {
  const PmForecast({super.key});

  @override
  State<PmForecast> createState() => _PmForecastState();
}

class _PmForecastState extends State<PmForecast> {
  late List<_ChartData> data = [];
  late List<double> pm = List<double>.filled(7, 0.0);
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
    _tooltip = TooltipBehavior(
        textStyle: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),
        enable: true,
        color: Color.fromARGB(255, 255, 255, 255));
    getWeather();
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
            padding:
                const EdgeInsets.only(top: 5, bottom: 8, right: 8, left: 8),
            child: SfCartesianChart(
              isTransposed: true,
              enableAxisAnimation: true,
              title: ChartTitle(
                  text: 'PM 2.5',
                  textStyle: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    animationDelay: 4000,
                    borderColor: const Color.fromARGB(255, 255, 255, 255),
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: "PM 2.5",
                    pointColorMapper: (_ChartData data, _) =>
                        getBarColor(data.y),
                    color: Colors.deepPurpleAccent)
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
      var uri = 'http://10.0.2.2:8000/forecast';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var responseData = response.body;
        var decodedData = json.decode(responseData);

        List<double> xValues = [];

        // Extract values
        for (var i = 7; i <= 13; i++) {
          if (decodedData['PM25'] != null &&
              decodedData['PM25'][i.toString()] != null) {
            xValues.add(decodedData['PM25'][i.toString()].toDouble());
          } else {
            xValues.add(0.0); // Or any default value you prefer
          }
        }

        setState(() {
          // Update data list
          data = List.generate(xValues.length, (index) {
            if (index == 0) {
              return _ChartData(
                "Tomorrow",
                xValues[index],
              );
            } else {
              DateTime currentDate =
                  DateTime.now().add(Duration(days: index + 1));
              return _ChartData(
                DateFormat('E').format(currentDate),
                xValues[index],
              );
            }
          });
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
