// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class RainFall extends StatefulWidget {
  double level;
  RainFall({Key? key, required this.level}) : super(key: key);

  @override
  State<RainFall> createState() => _RainFallState();
}

class _RainFallState extends State<RainFall> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 255, 255, 255)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rain Fall/24Hr",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image(
                    height: MediaQuery.of(context).size.width * 0.025,
                    width: MediaQuery.of(context).size.width * 0.025,
                    image: AssetImage(
                      'assets/images/rain.png',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/noun-beaker.png')),
                    border: Border.all(
                        width: 5, color: const Color.fromARGB(255, 35, 35, 36)),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 200.0 - widget.level * 2.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 4, 201, 245),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                            bottom: Radius.circular(10)),
                      ),
                      child: Center(child: Text("${widget.level} cm")),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
