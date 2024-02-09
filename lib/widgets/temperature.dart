// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Temperature extends StatefulWidget {
  double temp;
  Temperature({super.key, required this.temp});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Temperature",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Image(
                    height: MediaQuery.of(context).size.width * 0.025,
                    width: MediaQuery.of(context).size.width * 0.025,
                    image: AssetImage(
                      'assets/images/thermometer-outline.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SfRadialGauge(
                  animationDuration: 4000,
                  enableLoadingAnimation: true,
                  axes: <RadialAxis>[
                    RadialAxis(
                      axisLabelStyle: GaugeTextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      axisLineStyle: AxisLineStyle(
                          thickness: 10,
                          color: Color.fromARGB(205, 101, 98, 98),
                          cornerStyle: CornerStyle.bothCurve),
                      pointers: <GaugePointer>[
                        WidgetPointer(
                          value: widget.temp,
                          animationDuration: 4000,
                          animationType: AnimationType.ease,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.01,
                            height: MediaQuery.of(context).size.width * 0.01,
                            decoration: BoxDecoration(
                                color: getBarColor(widget.temp),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Color.fromARGB(218, 105, 105, 102),
                                    style: BorderStyle.solid,
                                    width: 1.0)),
                          ),
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                          verticalAlignment: GaugeAlignment.center,
                          widget: Center(
                            child: Text(
                              ' ${widget.temp}°C',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: getBarColor(widget.temp)),
                            ),
                          ),
                          angle: 90,
                          positionFactor: 0.1,
                          horizontalAlignment: GaugeAlignment.center,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getBarColor(double value) {
    if (value < 30.0) {
      return Colors.green;
    } else if (value < 40.0) {
      return Colors.yellow;
    } else {
      return Color.fromARGB(255, 229, 160, 63);
    }
  }
}
