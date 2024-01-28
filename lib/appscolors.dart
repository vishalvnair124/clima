import "package:flutter/material.dart";

Color appBgColor = const Color.fromRGBO(53, 53, 53, 1.0);
Color appTxColor = Colors.white;
Color temp = Colors.black;
bool themeOfApp = true;

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
