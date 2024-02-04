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
          axisLineStyle: AxisLineStyle(thickness: 25),
          showTicks: false,
          pointers: <GaugePointer>[
            NeedlePointer(
                value: widget.preValue,
                enableAnimation: true,
                needleStartWidth: 0,
                needleEndWidth: 5,
                needleColor: Color.fromARGB(255, 37, 37, 37),
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
                color: Color.fromARGB(255, 242, 191, 113))
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '${widget.preValue}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
}
