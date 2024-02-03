// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Compass extends StatefulWidget {
  double dir;
  Compass({Key? key, required this.dir}) : super(key: key);

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          startAngle: 270,
          endAngle: 270,
          radiusFactor: 0.9,
          minimum: 0,
          maximum: 80,
          axisLineStyle: AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor, thickness: 0.1),
          interval: 10,
          canRotateLabels: true,
          axisLabelStyle: GaugeTextStyle(fontSize: 12),
          minorTicksPerInterval: 0,
          majorTickStyle: MajorTickStyle(
              thickness: 1.5, lengthUnit: GaugeSizeUnit.factor, length: 0.07),
          showLabels: true,
          onLabelCreated: labelCreated,
          pointers: <GaugePointer>[
            NeedlePointer(
                animationType: AnimationType.easeOutBack,
                enableAnimation: true,
                animationDuration: 1000,
                value: widget.dir,
                lengthUnit: GaugeSizeUnit.factor,
                needleLength: 0.55,
                needleEndWidth: 18,
                gradient: const LinearGradient(colors: <Color>[
                  Color(0xFFFF6B78),
                  Color(0xFFFF6B78),
                  Color(0xFFE20A22),
                  Color(0xFFE20A22)
                ], stops: <double>[
                  0,
                  0.5,
                  0.5,
                  1
                ]),
                needleColor: const Color(0xFFF67280),
                knobStyle: KnobStyle(
                    knobRadius: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.white)),
            NeedlePointer(
                animationType: AnimationType.easeOutBack,
                enableAnimation: true,
                animationDuration: 1000,
                gradient: const LinearGradient(colors: <Color>[
                  Color.fromARGB(255, 245, 242, 242),
                  Color.fromARGB(255, 197, 194, 194),
                  Color(0xFF7A7A7A),
                  Color(0xFF7A7A7A)
                ], stops: <double>[
                  0,
                  0.5,
                  0.5,
                  1
                ]),
                value: opposite(),
                needleLength: 0.55,
                lengthUnit: GaugeSizeUnit.factor,
                needleColor: Color.fromARGB(255, 227, 224, 224),
                needleEndWidth: 18,
                knobStyle: KnobStyle(
                    knobRadius: 0.1,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Colors.white))
          ],
        )
      ],
    );
  }

  void labelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '80' || args.text == '0') {
      args.text = 'N';
    } else if (args.text == '10') {
      args.text = 'NE';
    } else if (args.text == '20') {
      args.text = 'E';
    } else if (args.text == '30') {
      args.text = 'SE';
    } else if (args.text == '40') {
      args.text = 'S';
    } else if (args.text == '50') {
      args.text = 'SW';
    } else if (args.text == '60') {
      args.text = 'W';
    } else if (args.text == '70') {
      args.text = 'NW';
    }
  }

  double opposite() {
    double oppositedir;
    if (widget.dir <= 40) {
      oppositedir = widget.dir + 40;
    } else {
      oppositedir = widget.dir - 40;
    }
    return oppositedir;
  }
}
