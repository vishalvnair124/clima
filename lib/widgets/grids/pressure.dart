// ignore_for_file: must_be_immutable

import 'package:clima/widgets/pmeter.dart';
import 'package:flutter/material.dart';

class Pressure extends StatefulWidget {
  double pre;
  Pressure({Key? key, required this.pre}) : super(key: key);

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
                      color: const Color.fromARGB(255, 255, 255, 255),
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
                  child: PMeter(
                preValue: widget.pre,
              )),
            ),
          ],
        ),
      ),
    );
  }
}
