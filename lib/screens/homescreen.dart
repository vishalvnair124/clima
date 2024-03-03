import 'package:clima/screens/analysedaily.dart';
import 'package:clima/screens/analysefullday.dart';
import 'package:clima/screens/forecast.dart';
import 'package:clima/screens/laptophome.dart';
import 'package:clima/screens/mobilehome.dart';
import 'package:clima/screens/settings.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clima',
          style: GoogleFonts.mada(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white), // Change icon color
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        flexibleSpace: Image(
          image: AssetImage('assets/images/ForestBG-1.png'),
          fit: BoxFit.fill,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: MediaQuery.of(context).size.width > 600
          ? PageView(
              controller: controller,
              children: [LaptopHome(), Container()],
            )
          : PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                MobileHomeScreen(),
                PageView(children: [
                  AnalseDaily(), // Placeholder for tab content
                  AnalyseFullDay()
                ]),
                Forecast(),
                Settings()
              ],
            ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/ForestBG.png'))),
              child: Text(
                'Clima',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                _onItemTapped(0);
                Navigator.of(context).pop();
              },
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Analysis'),
              leading: Icon(Icons.auto_graph),
              onTap: () {
                _onItemTapped(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Forcast'),
              leading: Icon(Icons.auto_graph),
              onTap: () {
                _onItemTapped(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                _onItemTapped(3);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      controller.jumpToPage(index);
    });
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
