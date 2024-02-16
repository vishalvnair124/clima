// ignore_for_file: must_be_immutable

import 'package:clima/widgets/circularpercentage.dart';
import 'package:flutter/material.dart';

class NoTwo extends StatefulWidget {
  double no2;
  NoTwo({Key? key, required this.no2}) : super(key: key);

  @override
  State<NoTwo> createState() => _NoTwoState();
}

class _NoTwoState extends State<NoTwo> {
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
                    "NO₂",
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
                      'assets/images/nitrogen-dioxide.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: CircularPercentage(
                  percent: widget.no2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
