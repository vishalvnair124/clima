import "package:flutter/material.dart";

Color appBgColor = const Color.fromARGB(255, 226, 220, 220);
Color appTxColor = const Color.fromRGBO(53, 53, 53, 1.0);
Color temp = Colors.black;
bool themeOfApp = false;

void colorChange() {
  if (themeOfApp) {
    themeOfApp = false;
  } else {
    themeOfApp = true;
  }
  temp = appBgColor;
  appBgColor = appTxColor;
  appTxColor = temp;
}
