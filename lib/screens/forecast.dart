import 'package:clima/screens/forecast/coforecast.dart';
import 'package:clima/screens/forecast/noforecast.dart';
import 'package:clima/screens/forecast/soforecast.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/forecast/aqiforecast.dart';
import 'package:clima/screens/forecast/pmforecast.dart';

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
