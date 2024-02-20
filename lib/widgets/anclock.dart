import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:intl/intl.dart';

class AnalogClocks extends StatefulWidget {
  const AnalogClocks({Key? key}) : super(key: key);

  @override
  State<AnalogClocks> createState() => _AnalogClocksState();
}

class _AnalogClocksState extends State<AnalogClocks> {
  String? currentDate;
  String? currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Initialize the current date and time when the widget is initialized
    _updateDateTime();
    // Set up a timer to update the date and time every minute
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateDateTime();
    });
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is disposed to prevent memory leaks
    _timer.cancel();
    super.dispose();
  }

  void _updateDateTime() {
    setState(() {
      // Format current date as "DD-MM-YYYY"
      currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      // Format current time as "HH-MM-SS PM/AM"
      currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.11,
      height: MediaQuery.of(context).size.width * 0.11,
      child: Center(
        child: AnalogClock(
          dateTime: DateTime.now(),
          isKeepTime: true,
          dialColor: Color.fromARGB(255, 255, 255, 255),
          dialBorderColor: Colors.black,
          dialBorderWidthFactor: 0.02,
          markingColor: Colors.black,
          markingRadiusFactor: 1.0,
          markingWidthFactor: 1.0,
          hourNumberColor: Colors.black,
          hourNumbers: const [
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            '10',
            '11',
            '12'
          ],
          hourNumberSizeFactor: 1.0,
          hourNumberRadiusFactor: 1.0,
          hourHandColor: Colors.black,
          hourHandWidthFactor: 1.0,
          hourHandLengthFactor: 1.0,
          minuteHandColor: Colors.black,
          minuteHandWidthFactor: 1.0,
          minuteHandLengthFactor: 1.0,
          secondHandColor: Colors.black,
          secondHandWidthFactor: 1.0,
          secondHandLengthFactor: 1.0,
          centerPointColor: Colors.black,
          centerPointWidthFactor: 1.0,
          child: Align(
            alignment: FractionalOffset(0.5, 0.75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  currentDate ?? '',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 58, 74, 81)),
                ), // Display current date
                Text(
                  currentTime ?? '',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 58, 74, 81)),
                ), // Display current time
              ],
            ),
          ),
        ),
      ),
    );
  }
}
