// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CircularPercentage extends StatefulWidget {
  final double percent;

  CircularPercentage({Key? key, required this.percent}) : super(key: key);

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
              color: getColor(
                  widget.percent), // Change the color for the progress pointer
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
                  color:
                      getColor(widget.percent), // Change the color for the text
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

  Color getColor(double value) {
    if (value < 30.0) {
      return Colors.green;
    } else if (value < 35.0) {
      return Colors.yellow;
    } else if (value < 38.0) {
      return Color.fromARGB(195, 237, 148, 4);
    } else if (value < 442.0) {
      return Color.fromARGB(255, 255, 98, 0);
    } else {
      return const Color.fromARGB(255, 237, 19, 3);
    }
  }
}
