class DailyWeatherData {
  int? weatherId;
  double? temperature;
  double? humidity;
  double? pressure;
  double? rainfall;
  double? uvIndex;
  double? windSpeed;
  int? windDirection;

  double? coLevel;
  double? pm25;
  double? so2Level;
  double? no2Level;
  String? recordedTime;
  String? recordedDate;

  DailyWeatherData({
    this.weatherId,
    this.temperature,
    this.humidity,
    this.pressure,
    this.rainfall,
    this.uvIndex,
    this.windSpeed,
    this.windDirection,
    this.coLevel,
    this.pm25,
    this.so2Level,
    this.no2Level,
    this.recordedTime,
    this.recordedDate,
  });

  factory DailyWeatherData.fromJson(Map<String, dynamic> json) {
    return DailyWeatherData(
      weatherId: json['Weather_id'],
      temperature: json['Temperature']?.toDouble() ?? 0.0,
      humidity: json['Humidity']?.toDouble() ?? 0.0,
      pressure: json['Pressure']?.toDouble() ?? 0.0,
      rainfall: json['Rainfall']?.toDouble() ?? 0.0,
      uvIndex: json['UV_Index']?.toDouble() ?? 0.0,
      windSpeed: json['Wind_Speed']?.toDouble() ?? 0.0,
      windDirection: json['Wind_Direction'],
      coLevel: json['CO_Level']?.toDouble() ?? 0.0,
      pm25: json['PM2.5']?.toDouble() ?? 0.0,
      so2Level: json['SO2_Level']?.toDouble() ?? 0.0,
      no2Level: json['NO2_Level']?.toDouble() ?? 0.0,
      recordedTime: json['Recorded_Time'] ?? '',
      recordedDate: json['Recorded_Date'] ?? '',
    );
  }
}

List<DailyWeatherData> parseDailyWeatherData(Map<String, dynamic> jsonMap) {
  List<DailyWeatherData> weatherDataList = [];
  jsonMap.forEach((key, value) {
    DailyWeatherData weatherData = DailyWeatherData(
      weatherId: value['Weather_id'],
      temperature: value['Temperature']?.toDouble() ?? 0.0,
      humidity: value['Humidity']?.toDouble() ?? 0.0,
      pressure: value['Pressure']?.toDouble() ?? 0.0,
      rainfall: value['Rainfall']?.toDouble() ?? 0.0,
      uvIndex: value['UV_Index']?.toDouble() ?? 0.0,
      windSpeed: value['Wind_Speed']?.toDouble() ?? 0.0,
      windDirection: value['Wind_Direction'],
      coLevel: value['CO_Level']?.toDouble() ?? 0.0,
      pm25: value['PM2.5']?.toDouble() ?? 0.0,
      so2Level: value['SO2_Level']?.toDouble() ?? 0.0,
      no2Level: value['NO2_Level']?.toDouble() ?? 0.0,
      recordedTime: value['Recorded_Time'] ?? '',
      recordedDate: value['Recorded_Date'] ?? '',
    );
    weatherDataList.add(weatherData);
  });
  return weatherDataList;
}
