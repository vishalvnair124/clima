// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomDropDownButtonclass extends StatelessWidget {
  List<String> values;
  double width;
  CustomDropDownButtonclass(
      {super.key, required this.values, required this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      width: width,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(107, 102, 102, 1),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: DropdownButton(
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          alignment: Alignment.center,
          value: values.first,
          dropdownColor: const Color.fromRGBO(107, 102, 102, 1),
          underline: Container(),
          onChanged: (_) {},
          items: values
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList()),
    );
  }
}
