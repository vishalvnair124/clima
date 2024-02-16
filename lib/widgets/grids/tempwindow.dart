// ignore_for_file: must_be_immutable

import 'package:clima/widgets/temperature.dart';
import 'package:flutter/material.dart';

class TempWindow extends StatefulWidget {
  double temp;
  TempWindow({Key? key, required this.temp}) : super(key: key);

  @override
  State<TempWindow> createState() => _TempWindowState();
}

class _TempWindowState extends State<TempWindow> {
  @override
  Widget build(BuildContext context) {
    return Temperature(
      temp: widget.temp,
    );
  }
}
