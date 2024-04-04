import 'dart:async';
import 'dart:convert';
import 'package:clima/aqicalculate.dart';
import 'package:clima/colorandvalue.dart';
import 'package:http/http.dart' as http;
import 'package:clima/model/weather_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileLatest extends StatefulWidget {
  const MobileLatest({super.key});

  @override
  State<MobileLatest> createState() => _MobileLatestState();
}

class _MobileLatestState extends State<MobileLatest> {
  late Timer _timer;
  bool isLoded = false;
  double temperature = 0; // Remove default value assignment
  double humidity = 0;
  double pressure = 0;
  double airQualityIndex = 0;

  double rainfall = 0;
  double uvIndex = 0;
  double windSpeed = 0;
  int windDirection = 0;
  double coLevel = 0;
  double pm25 = 0;
  double so2Level = 0;
  double no2Level = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Clima',
          style: GoogleFonts.mada(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        flexibleSpace: Image(
          image: AssetImage('assets/images/ForestBG-1.png'),
          fit: BoxFit.fill,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 234, 229, 229)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              //humidity
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
                              "Humidity", //humidity
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
                              "Pressure", //Pressure
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
                              "${pressure}",
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
                              "Temperature", //Temperature
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
                              "${temperature}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "°C",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForTemperature(
                              temperature)['situation'],
                          style: GoogleFonts.mada(
                            color: getColorAndSituationForTemperature(
                                temperature)['color'],
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
                              "Rain Fall/24 Hr",
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
                              "${rainfall}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Cm",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForRainfall(
                              rainfall)['situation'],
                          style: GoogleFonts.mada(
                            color: getColorAndSituationForRainfall(
                                rainfall)['color'],
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
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
                              "AQI",
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
                              "${airQualityIndex.toStringAsFixed(2)}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForAQI(
                              airQualityIndex)['situation'],
                          style: GoogleFonts.mada(
                            color: getColorAndSituationForAQI(
                                airQualityIndex)['color'],
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
                              "CO",
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
                              "${coLevel}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForCO(coLevel)['situation'],
                          style: GoogleFonts.mada(
                            color: getColorAndSituationForCO(coLevel)['color'],
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
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
                              "PM 2.5",
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
                              "${pm25}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForPM25(pm25)['situation'],
                          style: GoogleFonts.mada(
                            color: getColorAndSituationForPM25(pm25)['color'],
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
                              "SO₂",
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
                              "${so2Level}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForSO2(so2Level)['situation'],
                          style: GoogleFonts.mada(
                            color:
                                getColorAndSituationForSO2(so2Level)['color'],
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
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
                              "NO₂",
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
                              "${no2Level}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForNO2(no2Level)['situation'],
                          style: GoogleFonts.mada(
                            color:
                                getColorAndSituationForNO2(no2Level)['color'],
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
                              "UV",
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
                              "${uvIndex}",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForUV(uvIndex)['situation'],
                          style: GoogleFonts.mada(
                            color: getColorAndSituationForUV(uvIndex)['color'],
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ],
                    ),
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
                              "Wind speed",
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
                              windSpeed.toStringAsFixed(1),
                              style: GoogleFonts.mada(
                                  color: Color(0xFF454545),
                                  fontSize: 55,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "M/s",
                              style: GoogleFonts.mada(
                                  color: Color(0xFF5F5F5F),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Text(
                          getColorAndSituationForWindSpeed(
                              windSpeed)['situation'],
                          style: GoogleFonts.mada(
                            color: getColorAndSituationForWindSpeed(
                                windSpeed)['color'],
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
                              "Wind direction",
                              style: GoogleFonts.mada(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Text(
                            "${labelCreated(windDirection.toDouble())} ➡️ ${labelCreated(opposite(windDirection.toDouble()))}",
                            style: GoogleFonts.mada(
                                color: Color(0xFF454545),
                                fontSize: 40,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  String labelCreated(double direction) {
    String text;

    if (direction >= 80 || direction <= 0) {
      text = 'N';
    } else if (direction <= 10) {
      text = 'NE';
    } else if (direction <= 20) {
      text = 'E';
    } else if (direction <= 30) {
      text = 'SE';
    } else if (direction <= 40) {
      text = 'S';
    } else if (direction <= 50) {
      text = 'SW';
    } else if (direction <= 60) {
      text = 'W';
    } else if (direction <= 70) {
      text = 'NW';
    } else if (direction > 70) {
      text = 'N';
    } else {
      // Handle unknown direction code
      text = 'Unknown';
    }
    return text;
  }

  double opposite(double direction) {
    double oppositedir;
    if (direction <= 40) {
      oppositedir = direction + 40;
    } else {
      oppositedir = direction - 40;
    }
    return oppositedir;
  }

  void getWeather() async {
    var client = http.Client();
    try {
      var uri = 'http://10.0.2.2:8000/latest_weather';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;
        print(data);
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
          uvIndex = weatherData.uvIndex!;
          windSpeed = weatherData.windSpeed!;
          windDirection = weatherData.windDirection!;
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
