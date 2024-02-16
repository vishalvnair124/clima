// ignore_for_file: must_be_immutable

import 'package:clima/widgets/meter.dart';
import 'package:flutter/material.dart';

class Humidity extends StatefulWidget {
  double hum;
  Humidity({Key? key, required this.hum}) : super(key: key);

  @override
  State<Humidity> createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Humidity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image(
                    height: MediaQuery.of(context).size.width * 0.025,
                    width: MediaQuery.of(context).size.width * 0.025,
                    image: AssetImage(
                      'assets/images/weather_humidity.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                  child: HPMeter(
                preValue: widget.hum,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
