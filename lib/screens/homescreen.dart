import 'package:clima/screens/laptopscreen.dart';
import 'package:clima/screens/mobilescreen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 61, 59, 59),
          title: Text(
            'Clima',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
        body: MediaQuery.of(context).size.width > 600
            ? LaptopScreen()
            : MobileScreen(),
      ),
    );
  }

  int gridCount(double deviceWidth) {
    if (deviceWidth > 1200) {
      return 4;
    }
    if (deviceWidth > 600) {
      return 2;
    }
    return 1;
  }
}
