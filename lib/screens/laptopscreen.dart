import 'package:clima/appscolors.dart';
import 'package:clima/widgets/custom_dropdow_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      lastDate: DateTime.now(), // Set lastDate to the current date
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: appBgColor),
      child: Row(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: deviceWidth * 0.2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/sidebar.jpg"))),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  "22°C",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.w400),
                ),
                Text(
                  "temperature       ",
                  style: TextStyle(fontWeight: FontWeight.w700),
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
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Color.fromARGB(53, 53, 3, 3),
                        onPressed: () {
                          _showDatePicker(); // Corrected method name
                        },
                        child: Text(
                          "${DateFormat('dd-MM-yyyy').format(
                            DateTime.now(),
                          )}", // Corrected spelling

                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: deviceWidth * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                              rightTitles:
                                  AxisTitles(drawBelowEverything: false),
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
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: deviceWidth * 0.8,
                  child: GridView.count(
                    crossAxisCount: gridCount(deviceWidth),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/sun.png"),
                                ),
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
                                          fontSize: 60,
                                          fontWeight: FontWeight.w400),
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
                                  rightTitles:
                                      AxisTitles(drawBelowEverything: false),
                                  topTitles:
                                      AxisTitles(drawBelowEverything: false),
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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

  Widget _dropDownWidget(double Width) {
    return CustomDropDownButtonclass(
        values: const ["12-10-2023", "11-10-2023", "10-10-2023"], width: Width);
  }
}
