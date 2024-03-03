import 'package:clima/screens/coforecast.dart';
import 'package:clima/screens/noforecast.dart';
import 'package:clima/screens/soforecast.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/aqiforecast.dart';
import 'package:clima/screens/pmforecast.dart';

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AqiForecast(),
          PmForecast(),
          CoForecast(),
          SoForecast(),
          NoForecast()
        ],
      ),
    );
  }
}
