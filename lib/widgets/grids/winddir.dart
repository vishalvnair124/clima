import 'package:clima/widgets/compass.dart';
import 'package:flutter/material.dart';

class WindDirection extends StatefulWidget {
  const WindDirection({super.key});

  @override
  State<WindDirection> createState() => _WindDirectionState();
}

class _WindDirectionState extends State<WindDirection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Wind direction",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                  Image(
                      height: MediaQuery.of(context).size.width * 0.025,
                      width: MediaQuery.of(context).size.width * 0.025,
                      image:
                          const AssetImage('assets/images/noun-direction.png'))
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Compass(
                  dir: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
