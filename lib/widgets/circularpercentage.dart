// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularPercentage extends StatefulWidget {
  final double size;
  final double percent;

  CircularPercentage({Key? key, required this.size, required this.percent})
      : super(key: key);

  @override
  State<CircularPercentage> createState() => _CircularPercentageState();
}

class _CircularPercentageState extends State<CircularPercentage> {
  _CircularPercentageState();

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          radiusFactor: 0.8,
          axisLineStyle: AxisLineStyle(
            thickness: 0.3,
            color: const Color.fromARGB(
                255, 218, 222, 225), // Change the color for the progress bar
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              value: widget.percent,
              width: 0.3,
              sizeUnit: GaugeSizeUnit.factor,
              enableAnimation: true,
              animationDuration: 4000,
              animationType: AnimationType.bounceOut,
              color: const Color.fromARGB(255, 76, 168,
                  175), // Change the color for the progress pointer
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              positionFactor: 0.2,
              horizontalAlignment: GaugeAlignment.center,
              verticalAlignment: GaugeAlignment.center,
              widget: Text(
                '${widget.percent}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(
                      255, 0, 0, 0), // Change the color for the text
                ),
              ),
            ),
          ],
        ),
        RadialAxis(
          minimum: 0,
          maximum: 100,
          showLabels: false,
          showTicks: false,
          showAxisLine: true,
          tickOffset: -0.05,
          offsetUnit: GaugeSizeUnit.factor,
          minorTicksPerInterval: 0,
          radiusFactor: 0.8,
          axisLineStyle: AxisLineStyle(
            thickness: 0.3,
            color: const Color.fromARGB(
                255, 234, 231, 231), // Change the color for the dashed line
            dashArray: <double>[4, 3],
            thicknessUnit: GaugeSizeUnit.factor,
          ),
        ),
      ],
    );
  }
}
