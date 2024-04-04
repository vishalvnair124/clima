import 'dart:convert';
import 'package:clima/aqicalculate.dart';
import 'package:clima/colorandvalue.dart';
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
                maximum: 500,
                interval: 25,
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
                        getColorAndSituationForAQI(data.y)['color'],
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

        print(decodedData);

        List<double> aqiValues = [];

        // Extract PM25 values
        for (var i = 7; i <= 13; i++) {
          if (decodedData['PM25'] != null &&
              decodedData['PM25'][i.toString()] != null) {
            double pm25Value = decodedData['PM25'][i.toString()].toDouble();
            // Calculate AQI for the current PM25 value
            double aqi = overallAqi(
              pm25Value,
              decodedData['SO2']?[i.toString()]?.toDouble() ?? 0.0,
              decodedData['CO']?[i.toString()]?.toDouble() ?? 0.0,
              decodedData['NO2']?[i.toString()]?.toDouble() ?? 0.0,
            );
            aqiValues.add(aqi);
          } else {
            aqiValues.add(0.0); // Or any default value you prefer
          }
        }

        setState(() {
          aqi = aqiValues;

          // Generate data for the next 7 days
          data = List.generate(aqi.length, (index) {
            DateTime currentDate = DateTime.now()
                .add(Duration(days: index + 1)); // Start from tomorrow
            String label =
                index == 0 ? "Tomorrow" : DateFormat('E').format(currentDate);
            return _ChartData(label, aqi[index]);
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
