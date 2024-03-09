import 'package:clima/screens/analysis/aqianalysis.dart';
import 'package:clima/screens/analysis/coanalysis.dart';
import 'package:clima/screens/analysis/humidityanalysis.dart';
import 'package:clima/screens/analysis/noanalysis.dart';
import 'package:clima/screens/analysis/pmanalysis.dart';
import 'package:clima/screens/analysis/pressureanalysis.dart';
import 'package:clima/screens/analysis/rainanalysis.dart';
import 'package:clima/screens/analysis/soanalsis.dart';
import 'package:clima/screens/analysis/tempratureanalysis.dart';
import 'package:clima/screens/analysis/uvanalysis.dart';
import 'package:clima/screens/analysis/windspeedanalysis.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AnalysisFullDay extends StatefulWidget {
  const AnalysisFullDay({super.key});

  @override
  State<AnalysisFullDay> createState() => _AnalysisFullDayState();
}

class _AnalysisFullDayState extends State<AnalysisFullDay> {
  DateTime selectedDate = DateTime.now();
  bool isLoded = false;

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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: const Color(0xFF3BDD38),
                  onPressed: () {
                    _showDatePicker(); // Corrected method name
                    getWeather();
                  },
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(
                      selectedDate,
                    ), // Corrected spelling

                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
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
                TemperatureAnalysis(
                  key:
                      UniqueKey(), // Add a unique key to force rebuild when the date changes
                  date: selectedDate,
                ),
                AqiAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                WindSpeedAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                CoAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                PmAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                SoAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                NoAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                HumidityAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                PressureAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                UvAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
                RainAnalysis(
                  key: UniqueKey(),
                  date: selectedDate,
                ),
              ],
            ),
          )
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
        setState(() {
          isLoded = true;
        });
      } else {
        print('Request failed with status  eee: ${response.statusCode}');
        setState(() {
          isLoded = false;
        });
      }
    } catch (e) {
      print('Error fetching weather: $e');
    } finally {
      client.close();
    }
  }
}
