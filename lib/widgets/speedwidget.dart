import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedWidget extends StatefulWidget {
  final double speed;

  const SpeedWidget({Key? key, required this.speed}) : super(key: key);

  @override
  State<SpeedWidget> createState() => _SpeedWidgetState();
}

class _SpeedWidgetState extends State<SpeedWidget> {
  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      animationDuration: 4000,
      enableLoadingAnimation: true,
      axes: <RadialAxis>[
        RadialAxis(
          majorTickStyle: MajorTickStyle(
              color: Colors.amberAccent,
              thickness: 1.5,
              lengthUnit: GaugeSizeUnit.factor,
              length: 0.07),
          minorTickStyle:
              MinorTickStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          showLastLabel: true,
          axisLabelStyle:
              GaugeTextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          minimum: 0,
          maximum: 140,
          interval: 10,
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 50,
              color: Colors.green,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 50,
              endValue: 100,
              color: Colors.orange,
              startWidth: 10,
              endWidth: 10,
            ),
            GaugeRange(
              startValue: 100,
              endValue: 150,
              color: Colors.red,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              needleColor: Color.fromARGB(255, 214, 211, 211),
              value: widget.speed,
              enableAnimation: true,
              enableDragging: true,
              animationDuration: 4000,
              knobStyle:
                  KnobStyle(color: const Color.fromARGB(255, 170, 174, 174)),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  '${widget.speed} km/h',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: getColor(widget.speed)),
                ),
              ),
              angle: 90,
              positionFactor: 0.3,
            ),
          ],
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
