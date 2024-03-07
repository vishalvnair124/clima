import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clima/model/hour_weather_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AnalsisDaily extends StatefulWidget {
  const AnalsisDaily({super.key});

  @override
  State<AnalsisDaily> createState() => _AnalsisDailyState();
}

class _AnalsisDailyState extends State<AnalsisDaily> {
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

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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

  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 234, 229, 229)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
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
                    color: Color(0xFF3BDD38),
                    onPressed: () {
                      _showTimePicker();
                    },
                    child: Text(
                      "${selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
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
            Visibility(
              visible: isLoded,
              replacement: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Text(
                    "NO data Available",
                    style: GoogleFonts.mada(
                        color: Color(0xFF454545),
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                                  "${pressure.toStringAsFixed(1)}",
                                  style: GoogleFonts.mada(
                                      color: Color(0xFF454545),
                                      fontSize: 50,
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                                  "${airQualityIndex}",
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                                  "${windSpeed}",
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
                              "Normal",
                              style: GoogleFonts.mada(
                                color: Color(0xFF3BDD38),
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String labelCreated(double direction) {
    String text;

    if (direction <= 0) {
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
      var uri =
          'http://10.0.2.2:8000/hourly_weather/ ${DateFormat('yyyy-MM-dd').format(selectedDate)}/${selectedTime.hour}';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;
        print(data);
        Map<String, dynamic> jsonMap = json.decode(data);
        HourWeatherData weatherData = HourWeatherData.fromJson(jsonMap);

        setState(() {
          isLoded = true;
          airQualityIndex = weatherData.airQualityIndex!;
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
        setState(() {
          isLoded = false;
        });
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching weather: $e');
    } finally {
      client.close();
    }
  }

  void initState() {
    super.initState();
    getWeather();
  }
}
