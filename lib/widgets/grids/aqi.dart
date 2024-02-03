import 'package:clima/widgets/circularpercentage.dart';
import 'package:flutter/material.dart';

class AqiIndex extends StatefulWidget {
  const AqiIndex({super.key});

  @override
  State<AqiIndex> createState() => _AqiIndexState();
}

class _AqiIndexState extends State<AqiIndex> {
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
                    "AQI",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image(
                    height: MediaQuery.of(context).size.width * 0.025,
                    width: MediaQuery.of(context).size.width * 0.025,
                    image: AssetImage(
                      'assets/images/noun-air-quality-index.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: CircularPercentage(
                  percent: 47,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
