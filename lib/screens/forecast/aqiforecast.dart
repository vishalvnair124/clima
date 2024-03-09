import 'dart:convert';
import 'package:clima/aqicalculate.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AqiForecast extends StatefulWidget {
  const AqiForecast({super.key});

  @override
  State<AqiForecast> createState() => _AqiForecastState();
}

class _AqiForecastState extends State<AqiForecast> {
  late List<_ChartData> data = [];
  late List<double> aqi = List<double>.filled(7, 0.0);
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
                  text: 'AQI',
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
                    name: "AQI",
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
      aqi = List<double>.filled(7, 0.0);
      var uri = 'http://10.0.2.2:8000/forecast';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var responseData = response.body;
        var decodeData = json.decode(responseData);

        setState(() {
          for (int i = 0; i < 7; i++) {
            aqi[i] = overallAqi(
                decodeData['PM25']['100' + i.toString()],
                decodeData['SO2']['100' + i.toString()],
                decodeData['CO2']['100' + i.toString()],
                decodeData['NO2']['100' + i.toString()]);
          }
          data = [
            _ChartData("Tomorrow", aqi[0]),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 1)),
                ),
                aqi[1]),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 2)),
                ),
                aqi[2]),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 3)),
                ),
                aqi[3]),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 4)),
                ),
                aqi[4]),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 5)),
                ),
                aqi[5]),
            _ChartData(
                DateFormat('E').format(
                  DateTime.now().add(Duration(days: 6)),
                ),
                aqi[6]),
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
