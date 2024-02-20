// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class UvIndex extends StatefulWidget {
  double uvvlaue;
  UvIndex({Key? key, required this.uvvlaue}) : super(key: key);

  @override
  State<UvIndex> createState() => _UvIndexState();
}

class _UvIndexState extends State<UvIndex> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromARGB(255, 142, 139, 139)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "UV index",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image(
                    height: MediaQuery.of(context).size.width * 0.025,
                    width: MediaQuery.of(context).size.width * 0.025,
                    image: AssetImage(
                      'assets/images/uv_index.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "${widget.uvvlaue}",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfLinearGauge(
                      showAxisTrack: true,
                      maximum: 10,
                      minimum: 0,
                      interval: 1,
                      barPointers: [
                        LinearBarPointer(
                          value: widget.uvvlaue,
                          color: Colors.blue,
                        )
                      ],
                      useRangeColorForAxis: true,
                      animateAxis: true,
                      axisTrackStyle: LinearAxisTrackStyle(thickness: 10),
                      ranges: <LinearGaugeRange>[
                        LinearGaugeRange(
                            startValue: 0,
                            endValue: 3,
                            position: LinearElementPosition.outside,
                            color: Color(0xff0DC9AB)),
                        LinearGaugeRange(
                            startValue: 3,
                            endValue: 6,
                            position: LinearElementPosition.outside,
                            color: Color(0xffFFC93E)),
                        LinearGaugeRange(
                            startValue: 6,
                            endValue: 10,
                            position: LinearElementPosition.outside,
                            color: Color(0xffF45656)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
