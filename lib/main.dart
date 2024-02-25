import 'package:flutter/material.dart';
import 'package:clima/screens/loginandregister/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clima ',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
