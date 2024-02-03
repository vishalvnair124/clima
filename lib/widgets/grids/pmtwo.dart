import 'package:clima/widgets/circularpercentage.dart';
import 'package:flutter/material.dart';

class PmTwoPointFive extends StatefulWidget {
  const PmTwoPointFive({super.key});

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
          border: Border.all(),
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
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
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
                child: CircularPercentage(
                  percent: 44,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
