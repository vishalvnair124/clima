import 'dart:async';
import 'dart:convert';

import 'package:clima/appscolors.dart';
import 'package:clima/aqicalculate.dart';
import 'package:clima/colorandvalue.dart';
import 'package:clima/model/weather_data.dart';
import 'package:clima/screens/mobilelatest.dart';

import 'package:clima/widgets/mobilebarchar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  late Timer _timer;
  bool isLoded = false;
  double temperature = 0; // Remove default value assignment
  double humidity = 0;
  double pressure = 0;
  double airQualityIndex = 0;

  double rainfall = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage("assets/images/ForestBG-body.jpg"))),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromRGBO(187, 218, 200, 0.629)),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Pathanamthitta,konni",
                      style: GoogleFonts.mada(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 19,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              temaqi ? "Air Quality" : "Temperature",
              style: GoogleFonts.mada(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: temaqi ? 11 : 12,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              temaqi
                  ? getColorAndSituationForAQI(airQualityIndex)['situation']
                  : getColorAndSituationForTemperature(
                      temperature)['situation'],
              style: GoogleFonts.mada(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 21,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
            ),
            Visibility(
              replacement: CircularProgressIndicator(),
              visible: isLoded,
              child: Text(
                temaqi
                    ? "${airQualityIndex.toStringAsFixed(1)}"
                    : "${temperature.toStringAsFixed(1)}°c",
                style: GoogleFonts.mada(
                  height: 0.8,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: temaqi ? 120 : 110,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              temaqi ? "AQI" : "",
              style: GoogleFonts.mada(
                  height: 1.1,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 3, right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          changeTA();
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(temaqi
                                ? 'assets/images/thermometer-outline-2.png'
                                : 'assets/images/noun-air-quality-index.png'),
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(width: 3),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              temaqi
                                  ? "${temperature.toStringAsFixed(1)}°c"
                                  : "${airQualityIndex.toStringAsFixed(1)}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mada(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/rain.png'),
                          height: 30,
                          width: 30,
                        ),
                        SizedBox(width: 5),
                        Padding(
                          padding: const EdgeInsets.only(top: 11),
                          child: Text(
                            "${rainfall}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mada(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 234, 229, 229),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                                image: AssetImage(
                                    'assets/images/ForestBG-body.png'),
                              ),
                            ),
                            child: CustomMobileBarChart()),
                      )),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 250,
              color: Color.fromARGB(255, 234, 229, 229),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MobileLatest()),
                            );
                          },
                          child: Text(
                            "Current observation",
                            style: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )),
                      Row(
                        children: [
                          Text(
                            "More",
                            style: GoogleFonts.mada(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MobileLatest()),
                              );
                            },
                            icon: Icon(
                              Icons.arrow_right_sharp,
                              size: 30,
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 228, 223, 223),
                                width: 3),
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(
                              30,
                            )),
                        height: 200,
                        width: 200,
                        child: Column(
                          children: [
                            Align(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Humidity",
                                  style: GoogleFonts.mada(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${humidity}",
                                  style: GoogleFonts.mada(
                                      color: Color(0xFF454545),
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "%",
                                  style: GoogleFonts.mada(
                                      color: Color(0xFF5F5F5F),
                                      fontSize: 45,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              getColorAndSituationForHumidity(
                                  humidity)['situation'],
                              style: GoogleFonts.mada(
                                color: getColorAndSituationForHumidity(
                                    humidity)['color'],
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 228, 223, 223),
                                width: 3),
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(
                              30,
                            )),
                        height: 200,
                        width: 200,
                        child: Column(
                          children: [
                            Align(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Pressure",
                                  style: GoogleFonts.mada(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${pressure.toStringAsFixed(1)}",
                                  style: GoogleFonts.mada(
                                      color: Color(0xFF454545),
                                      fontSize: 45,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Pa",
                                  style: GoogleFonts.mada(
                                      color: Color(0xFF5F5F5F),
                                      fontSize: 40,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text(
                              getColorAndSituationForPressure(
                                  pressure)['situation'],
                              style: GoogleFonts.mada(
                                color: getColorAndSituationForPressure(
                                    pressure)['color'],
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void getWeather() async {
    var client = http.Client();
    try {
      var uri = 'http://10.0.2.2:8000/latest_weather';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;
        // print(data);
        Map<String, dynamic> jsonMap = json.decode(data);
        WeatherData weatherData = WeatherData.fromJson(jsonMap);

        setState(() {
          isLoded = true;
          airQualityIndex = overallAqi(weatherData.pm25!, weatherData.so2Level!,
              weatherData.coLevel!, weatherData.no2Level!);
          temperature = weatherData.temperature!;
          humidity = weatherData.humidity!;
          pressure = weatherData.pressure!;

          rainfall = weatherData.rainfall!;
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
