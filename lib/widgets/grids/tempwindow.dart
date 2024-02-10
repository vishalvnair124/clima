import 'package:clima/widgets/temperature.dart';
import 'package:flutter/material.dart';

class TempWindow extends StatefulWidget {
  const TempWindow({super.key});

  @override
  State<TempWindow> createState() => _TempWindowState();
}

class _TempWindowState extends State<TempWindow> {
  @override
  Widget build(BuildContext context) {
    return Temperature(
      temp: 40,
    );
  }
}
