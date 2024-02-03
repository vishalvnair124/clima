// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CircularPrecentage extends StatefulWidget {
  final double size;
  final double percent;

  CircularPrecentage({Key? key, required this.size, required this.percent})
      : super(key: key);

  @override
  State<CircularPrecentage> createState() => _CircularPrecentageState();
}

class _CircularPrecentageState extends State<CircularPrecentage> {
  _CircularPrecentageState();

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: Center(
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 4),
          builder: (context, value, child) {
            int percentage = (value * widget.percent).ceil();
            return Container(
              width: widget.size,
              height: widget.size,
              child: Stack(
                children: [
                  ShaderMask(
                    shaderCallback: (rect) {
                      return SweepGradient(
                        startAngle: 0.0,
                        endAngle: (3.14 * 2) * (percentage / 100),
                        stops: [value, value],
                        center: Alignment.center,
                        colors: [Colors.blue, Colors.grey.withAlpha(55)],
                      ).createShader(rect);
                    },
                    child: Container(
                      width: widget.size,
                      height: widget.size,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/radial_scale.png"),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: widget.size - 40,
                      height: widget.size - 40,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 237, 213, 213),
                        shape: BoxShape.circle,
                      ),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Center(
                          child: Text(
                            "$percentage",
                            style: const TextStyle(fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
