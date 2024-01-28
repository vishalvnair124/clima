import 'package:clima/appscolors.dart';
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
          actions: [
            Row(
              children: [
                themeStateOfApp(),
                const SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
        body: MediaQuery.of(context).size.width > 600
            ? LaptopScreen()
            : MobileScreen(),
      ),
    );
  }

  Widget themeStateOfApp() {
    return GestureDetector(
      onTap: () {
        setState(() {
          colorChange();
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 255, 255, 255)),
        height: 30,
        width: 60,
        child: Row(
            mainAxisAlignment:
                themeOfApp ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CircleAvatar(
                      backgroundImage: themeOfApp
                          ? const AssetImage('assets/images/moon.png')
                          : const AssetImage('assets/images/sun.png')),
                ),
              )
            ]),
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
