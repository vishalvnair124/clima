import 'package:clima/widgets/speedwidget.dart';
import 'package:flutter/material.dart';

class WindSpeed extends StatefulWidget {
  const WindSpeed({super.key});

  @override
  State<WindSpeed> createState() => _WindSpeedState();
}

class _WindSpeedState extends State<WindSpeed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), border: Border.all()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Wind Speed",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Image(
                      height: MediaQuery.of(context).size.width * 0.025,
                      width: MediaQuery.of(context).size.width * 0.025,
                      image:
                          const AssetImage('assets/images/noun-windsock.png'))
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: SpeedWidget(
                  speed: 52,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
