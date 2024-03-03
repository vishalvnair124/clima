import 'package:clima/screens/tempratureana.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalyseFullDay extends StatefulWidget {
  const AnalyseFullDay({super.key});

  @override
  State<AnalyseFullDay> createState() => _AnalyseFullDayState();
}

class _AnalyseFullDayState extends State<AnalyseFullDay> {
  DateTime selectedDate = DateTime.now();

  void _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025), // Change this to a date in the future
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  color: const Color(0xFF3BDD38),
                  onPressed: () {
                    _showDatePicker(); // Corrected method name
                  },
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(
                      selectedDate,
                    ), // Corrected spelling

                    style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
          TempAna(
            key:
                UniqueKey(), // Add a unique key to force rebuild when the date changes
            date: selectedDate,
          ),
        ],
      ),
    );
  }
}
