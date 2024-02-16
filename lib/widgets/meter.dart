// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HPMeter extends StatefulWidget {
  double preValue;
  HPMeter({super.key, required this.preValue});

  @override
  State<HPMeter> createState() => _HPMeterState();
}

class _HPMeterState extends State<HPMeter> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          axisLabelStyle: GaugeTextStyle(color: Colors.white),
          axisLineStyle: AxisLineStyle(thickness: 25),
          showTicks: false,
          pointers: <GaugePointer>[
            NeedlePointer(
                value: widget.preValue,
                enableAnimation: true,
                needleStartWidth: 0,
                needleEndWidth: 5,
                needleColor: Color.fromARGB(255, 156, 155, 158),
                knobStyle: KnobStyle(
                    color: Colors.white,
                    borderColor: Color.fromARGB(255, 37, 37, 37),
                    knobRadius: 0.06,
                    borderWidth: 0.04),
                tailStyle: TailStyle(
                    color: Color.fromARGB(255, 37, 37, 37),
                    width: 5,
                    length: 0.15)),
            RangePointer(
                value: widget.preValue,
                width: 25,
                enableAnimation: true,
                color: getColor(widget.preValue))
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '${widget.preValue}',
                  style: TextStyle(
                      color: getColor(widget.preValue),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        )
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
