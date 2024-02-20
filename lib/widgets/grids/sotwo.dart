// ignore_for_file: must_be_immutable

import 'package:clima/widgets/circularpercentage.dart';
import 'package:flutter/material.dart';

class SoTwo extends StatefulWidget {
  double so2;
  SoTwo({Key? key, required this.so2}) : super(key: key);

  @override
  State<SoTwo> createState() => _SoTwoState();
}

class _SoTwoState extends State<SoTwo> {
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
                    "SO₂",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image(
                    height: MediaQuery.of(context).size.width * 0.025,
                    width: MediaQuery.of(context).size.width * 0.025,
                    image: AssetImage(
                      'assets/images/sulfur-dioxide.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: CircularPercentage(
                  percent: widget.so2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
