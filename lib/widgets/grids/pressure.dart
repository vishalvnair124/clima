import 'package:clima/widgets/meter.dart';
import 'package:flutter/material.dart';

class Pressure extends StatefulWidget {
  const Pressure({super.key});

  @override
  State<Pressure> createState() => _PressureState();
}

class _PressureState extends State<Pressure> {
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
                    "Pressure",
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
                      'assets/images/pressure_icon.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                  child: HPMeter(
                preValue: 40,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
