import 'package:clima/screens/laptophome.dart';
import 'package:clima/screens/mobilehome.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Visibility(
          visible: (MediaQuery.of(context).size.width > 600),
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon:
                    Icon(Icons.menu, color: Colors.white), // Change icon color
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        flexibleSpace: Image(
          image: AssetImage('assets/images/ForestBG-1.png'),
          fit: BoxFit.fitWidth,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'Clima',
          style: GoogleFonts.mada(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
      body: MediaQuery.of(context).size.width > 600
          ? PageView(
              controller: controller,
              children: [LaptopHome(), Container()],
            )
          : PageView(
              controller: controller,
              children: [MobileHomeScreen()],
            ),
      bottomNavigationBar: Visibility(
        visible: (MediaQuery.of(context).size.width < 600),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/ForestBG-appBar.png'),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(27), topLeft: Radius.circular(27)),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.lightGreen,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Analysis',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Forcast',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Settings',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
      drawer: Visibility(
        visible: (MediaQuery.of(context).size.width > 600),
        child: Drawer(
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
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
