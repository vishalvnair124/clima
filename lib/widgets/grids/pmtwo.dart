// ignore_for_file: must_be_immutable

import 'package:clima/widgets/circularpercentage.dart';
import 'package:flutter/material.dart';

class PmTwoPointFive extends StatefulWidget {
  double pm;
  PmTwoPointFive({Key? key, required this.pm}) : super(key: key);

  @override
  State<PmTwoPointFive> createState() => _PmTwoPointFiveState();
}

class _PmTwoPointFiveState extends State<PmTwoPointFive> {
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
                    "PM 2.5",
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
                      'assets/images/pm25.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: CircularPercentage(
                  percent: widget.pm,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
