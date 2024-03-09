import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:clima/aqicalculate.dart';
import 'package:clima/model/weather_data.dart';

import 'package:clima/widgets/anclock.dart';
import 'package:clima/widgets/grids/aqi.dart';
import 'package:clima/widgets/barchart.dart';
import 'package:clima/widgets/grids/covalue.dart';
import 'package:clima/widgets/grids/humidity.dart';
import 'package:clima/widgets/grids/notwo.dart';
import 'package:clima/widgets/grids/pmten.dart';
import 'package:clima/widgets/grids/pmtwo.dart';
import 'package:clima/widgets/grids/pressure.dart';
import 'package:clima/widgets/grids/rainfall.dart';
import 'package:clima/widgets/grids/sotwo.dart';
import 'package:clima/widgets/grids/tempwindow.dart';
import 'package:clima/widgets/grids/uvindex.dart';
import 'package:clima/widgets/grids/winddir.dart';
import 'package:clima/widgets/grids/windspeed.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:clima/appscolors.dart';

class LaptopHome extends StatefulWidget {
  const LaptopHome({super.key});

  @override
  State<LaptopHome> createState() => _LaptopHomeState();
}

class _LaptopHomeState extends State<LaptopHome> {
  late Timer _timer;
  bool isLoded = false;
  double temperature = 0; // Remove default value assignment
  double humidity = 0;
  double pressure = 0;
  double rainfall = 0;
  double uvIndex = 0;
  double windSpeed = 0;
  int windDirection = 0;
  double airQualityIndex = 0;
  double coLevel = 0;
  double pm25 = 0;
  double so2Level = 0;
  double no2Level = 0;

  double size = 200.0;
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: appBgColor,
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/ForestBG.png'),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: deviceWidth * 0.2,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/side-forest.jpg"))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Visibility(
                      visible: isLoded,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: TempWindow(temp: temperature)),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AnalogClocks(),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 30,
                    width: deviceWidth * 0.8,
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: deviceWidth * 0.8,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)),
                      child: CustomBarChart(),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: deviceWidth * 0.8,
                    child: Visibility(
                      visible: isLoded,
                      replacement: Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: GridView.count(
                        crossAxisCount: gridCount(deviceWidth),
                        children: [
                          AqiIndex(aqi: airQualityIndex),
                          WindSpeed(speed: windSpeed),
                          WindDirection(dire: windDirection.toDouble()),
                          PmTenPointFive(pm: pm25),
                          ComoValue(co: coLevel),
                          PmTwoPointFive(pm: pm25),
                          SoTwo(so2: so2Level),
                          NoTwo(no2: no2Level),
                          Humidity(hum: humidity),
                          Pressure(pre: pressure),
                          RainFall(level: rainfall),
                          UvIndex(uvvlaue: uvIndex)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int gridCount(double deviceWidth) {
    if (deviceWidth > 1200) {
      return 4;
    }
    if (deviceWidth > 600) {
      return 2;
    }
    return 1;
  }

  void getWeather() async {
    var client = http.Client();
    try {
      var uri = 'http://127.0.0.1:8000/latest_weather';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;
        print(data);
        Map<String, dynamic> jsonMap = json.decode(data);
        WeatherData weatherData = WeatherData.fromJson(jsonMap);

        setState(() {
          isLoded = true;
          temperature = weatherData.temperature!;
          humidity = weatherData.humidity!;
          pressure = weatherData.pressure!;
          rainfall = weatherData.rainfall!;
          uvIndex = weatherData.uvIndex!;
          windSpeed = weatherData.windSpeed!;
          windDirection = weatherData.windDirection!;
          airQualityIndex = overallAqi(weatherData.pm25!, weatherData.so2Level!,
              weatherData.coLevel!, weatherData.no2Level!);
          coLevel = weatherData.coLevel!;
          pm25 = weatherData.pm25!;
          so2Level = weatherData.so2Level!;
          no2Level = weatherData.no2Level!;
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

  @override
  void initState() {
    super.initState();
    getWeather();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      getWeather();
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }
}
