import 'dart:convert';
import 'dart:ui';
import 'package:clima/constants.dart' as k;

import 'package:clima/widgets/anclock.dart';
import 'package:clima/widgets/grids/aqi.dart';
import 'package:clima/widgets/barchart.dart';
import 'package:clima/widgets/grids/covalue.dart';
import 'package:clima/widgets/grids/humidity.dart';
import 'package:clima/widgets/grids/notwo.dart';
import 'package:clima/widgets/grids/pmtwo.dart';
import 'package:clima/widgets/grids/pressure.dart';
import 'package:clima/widgets/grids/rainfall.dart';
import 'package:clima/widgets/grids/sotwo.dart';
import 'package:clima/widgets/grids/tempwindow.dart';
import 'package:clima/widgets/grids/winddir.dart';
import 'package:clima/widgets/grids/windspeed.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clima/appscolors.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class LaptopScreen extends StatefulWidget {
  const LaptopScreen({super.key});

  @override
  State<LaptopScreen> createState() => _LaptopScreenState();
}

class _LaptopScreenState extends State<LaptopScreen> {
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2003),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
  }

  bool isLoded = false;
  num temp = 0;
  num pressure = 0;
  num humidity = 0;

  double size = 200.0;
  @override
  Widget build(BuildContext context) {
    getWeather();
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: appBgColor,
        image: const DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/images/topbar.png'),
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
                      image: AssetImage("assets/images/sidebar.jpg"))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TempWindow(temp: 33.3),
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
                        MaterialButton(
                          color: const Color.fromARGB(53, 53, 3, 3),
                          onPressed: () {
                            _showDatePicker(); // Corrected method name
                          },
                          child: Text(
                            DateFormat('dd-MM-yyyy').format(
                              DateTime.now(),
                            ), // Corrected spelling

                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
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
                    child: GridView.count(
                      crossAxisCount: gridCount(deviceWidth),
                      children: [
                        AqiIndex(aqi: 30),
                        AqiIndex(aqi: 88),
                        WindSpeed(speed: 50),
                        WindDirection(dire: 30),
                        ComoValue(co: 23),
                        PmTwoPointFive(pm: 2.0),
                        SoTwo(so2: 13),
                        NoTwo(no2: 33),
                        Humidity(hum: 44),
                        Pressure(pre: 60.8),
                        RainFall(level: 44),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            child: Container(
                              child: SfLinearGauge(
                                maximum: 10,
                                minimum: 0,
                                interval: 1,
                                barPointers: [
                                  LinearBarPointer(
                                    value: 3,
                                    color: Colors.blue,
                                  )
                                ],
                                useRangeColorForAxis: true,
                                animateAxis: true,
                                axisTrackStyle:
                                    LinearAxisTrackStyle(thickness: 10),
                                ranges: <LinearGaugeRange>[
                                  LinearGaugeRange(
                                      startValue: 0,
                                      endValue: 3,
                                      position: LinearElementPosition.outside,
                                      color: Color(0xff0DC9AB)),
                                  LinearGaugeRange(
                                      startValue: 3,
                                      endValue: 6,
                                      position: LinearElementPosition.outside,
                                      color: Color(0xffFFC93E)),
                                  LinearGaugeRange(
                                      startValue: 6,
                                      endValue: 10,
                                      position: LinearElementPosition.outside,
                                      color: Color(0xffF45656)),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
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
      var uri = 'https://vishalvnair0124.pythonanywhere.com/';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;

        var decodedData = jsonDecode(data);
        var msg = decodedData['message'];
        print(msg);
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
  }
}
