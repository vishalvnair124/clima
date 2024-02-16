import 'package:clima/appscolors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:clima/constants.dart' as k;
import 'package:http/http.dart' as http;

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: appBgColor),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/topbar.png"))),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 70,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "22°C",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Text(
                          "temperature       ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.15,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all()),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "22°C",
                            style: TextStyle(
                                fontSize: 60, fontWeight: FontWeight.w400),
                          ),
                          Text("temperature       ")
                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                            color: const Color(0xff37434d), width: 1),
                      ),
                      titlesData: const FlTitlesData(
                        rightTitles: AxisTitles(drawBelowEverything: false),
                        topTitles: AxisTitles(drawBelowEverything: false),
                      ),
                      minX: 0,
                      maxX: 7,
                      minY: 0,
                      maxY: 6,
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            const FlSpot(0, 3),
                            const FlSpot(1, 1),
                            const FlSpot(2, 4),
                            const FlSpot(3, 2),
                            const FlSpot(4, 5),
                            const FlSpot(5, 5),
                            const FlSpot(6, 2),
                            const FlSpot(6, 4),
                          ],
                          isCurved: true,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getWeather() async {
    var client = http.Client();
    try {
      var uri = '${k.domain}';
      var url = Uri.parse(uri);
      var response = await client.get(url);

      if (response.statusCode == 200) {
        var data = response.body;
        print(data);
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
