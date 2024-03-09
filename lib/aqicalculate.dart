double calculateAqiPm25(double pm25) {
  List<double> breakpoints = [0, 12, 35.4, 55.4, 150.4, 250.4, 350.4, 500.4];
  List<int> aqiValues = [0, 50, 100, 150, 200, 300, 400, 500];

  for (int i = 1; i < breakpoints.length; i++) {
    if (pm25 <= breakpoints[i]) {
      double aqi = ((aqiValues[i] - aqiValues[i - 1]) /
                  (breakpoints[i] - breakpoints[i - 1])) *
              (pm25 - breakpoints[i - 1]) +
          aqiValues[i - 1];
      return aqi;
    }
  }
  return 0;
}

double calculateAqiSo2(double so2) {
  List<double> breakpoints = [0, 35, 75, 185, 304, 604, 804];
  List<int> aqiValues = [0, 50, 100, 150, 200, 300, 400];

  for (int i = 1; i < breakpoints.length; i++) {
    if (so2 <= breakpoints[i]) {
      double aqi = ((aqiValues[i] - aqiValues[i - 1]) /
                  (breakpoints[i] - breakpoints[i - 1])) *
              (so2 - breakpoints[i - 1]) +
          aqiValues[i - 1];
      return aqi;
    }
  }
  return 0;
}

double calculateAqiNo2(double no2) {
  List<double> breakpoints = [0, 53, 100, 360, 649, 1249, 1649];
  List<int> aqiValues = [0, 50, 100, 150, 200, 300, 400];

  for (int i = 1; i < breakpoints.length; i++) {
    if (no2 <= breakpoints[i]) {
      double aqi = ((aqiValues[i] - aqiValues[i - 1]) /
                  (breakpoints[i] - breakpoints[i - 1])) *
              (no2 - breakpoints[i - 1]) +
          aqiValues[i - 1];
      return aqi;
    }
  }
  return 0;
}

double calculateAqiCo(double co) {
  List<double> breakpoints = [0, 4.4, 9.4, 12.4, 15.4, 30.4, 40.4];
  List<int> aqiValues = [0, 50, 100, 150, 200, 300, 400];

  for (int i = 1; i < breakpoints.length; i++) {
    if (co <= breakpoints[i]) {
      double aqi = ((aqiValues[i] - aqiValues[i - 1]) /
                  (breakpoints[i] - breakpoints[i - 1])) *
              (co - breakpoints[i - 1]) +
          aqiValues[i - 1];
      return aqi;
    }
  }
  return 0;
}

double overallAqi(double pm25, double so2, double co, double no2) {
  double aqiPm25 = calculateAqiPm25(pm25);
  double aqiSo2 = calculateAqiSo2(so2);
  double aqiNo2 = calculateAqiNo2(no2);
  double aqiCo = calculateAqiCo(co);

  List<double> aqiList = [aqiPm25, aqiSo2, aqiNo2, aqiCo];
  double overallAqi =
      aqiList.reduce((value, element) => value > element ? value : element);
  return overallAqi;
}
