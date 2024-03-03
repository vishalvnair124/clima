import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:clima/model/daily_weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyseFullDay extends StatefulWidget {
  const AnalyseFullDay({super.key});

  @override
  State<AnalyseFullDay> createState() => _AnalyseFullDayState();
}

class _AnalyseFullDayState extends State<AnalyseFullDay> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  DateTime selectedDate = DateTime.now();
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

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025), // Change this to a date in the future
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    getWeather();
    _tooltip = TooltipBehavior(
      textStyle: TextStyle(color: const Color.fromARGB(255, 2, 2, 2)),
      enable: true,
      color: Color.fromARGB(255, 255, 255, 255),
    );

    data = [
      _ChartData(
        '12:00',
        22,
      ),
      _ChartData(
        '1:00',
        22,
      ),
      _ChartData(
        '2:00',
        22,
      ),
      _ChartData(
        '3:00',
        22,
      ),
      _ChartData(
        '4:00',
        22,
      ),
      _ChartData(
        '5:00',
        22,
      ),
      _ChartData(
        '6:00',
        22,
      ),
      _ChartData(
        '7:00',
        22,
      ),
      _ChartData(
        '8:00',
        22,
      ),
      _ChartData(
        '9:00',
        22,
      ),
      _ChartData(
        '10:00',
        22,
      ),
      _ChartData(
        '11:00',
        22,
      ),
      _ChartData(
        '12:00',
        22,
      ),
      _ChartData(
        '1:00',
        22,
      ),
      _ChartData(
        '2:00',
        22,
      ),
      _ChartData(
        '3:00',
        22,
      ),
      _ChartData(
        '4:00',
        22,
      ),
      _ChartData(
        '5:00',
        22,
      ),
      _ChartData(
        '6:00',
        22,
      ),
      _ChartData(
        '7:00',
        22,
      ),
      _ChartData(
        '8:00',
        22,
      ),
      _ChartData(
        '9:00',
        22,
      ),
      _ChartData(
        '10:00',
        22,
      ),
      _ChartData(
        '11:00',
        22,
      ),
      _ChartData(
        '12:00',
        22,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: const Color(0xFF3BDD38),
                  onPressed: () {
                    _showDatePicker(); // Corrected method name
                  },
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(
                      selectedDate,
                    ), // Corrected spelling

                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                MaterialButton(
                  color: const Color(0xFF3BDD38),
                  onPressed: () {
                    getWeather();
                  },
                  child: Text(
                    "  Show  ", // Corrected spelling

                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
          barChart('Air Quality'),
          barChart("Temperature"),
          barChart("CO2"),
          barChart("No2"),
          barChart("SO2"),
          barChart("PM 2.5"),
          barChart("Humidity"),
          barChart("Pressure"),
          barChart("Wind Speed"),
          barChart("Rain Fall/24"),
          barChart("UV Index"),
        ],
      ),
    );
  }

  void getWeather() async {
    var client = http.Client();
    try {
      var uri =
          'http://10.0.2.2:8000/hourly_weather/${DateFormat('yyyy-MM-dd').format(selectedDate)}';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;

        Map<String, dynamic> jsonMap = json.decode(data);
        List<DailyWeatherData> weatherDataList = parseDailyWeatherData(jsonMap);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather: $e');
    } finally {
      client.close();
    }
  }

  Widget barChart(
    String title,
  ) {
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
                  text: title,
                  textStyle: GoogleFonts.mada(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 17,
                      fontWeight: FontWeight.w500)),
              primaryXAxis: CategoryAxis(
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  axisLine:
                      AxisLine(color: Color.fromARGB(255, 255, 255, 255))),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 60,
                interval: 5,
                axisLine: AxisLine(
                  color: Color.fromARGB(
                      255, 255, 255, 255), // Change axis line color to white
                ),
                majorTickLines: MajorTickLines(
                  color: Color.fromARGB(255, 255, 255,
                      255), // Change major tick line color to white
                ),
                labelStyle: TextStyle(
                    color: Color.fromARGB(
                        255, 255, 255, 255)), // Change labels color to white
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
                    name: title,
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
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
