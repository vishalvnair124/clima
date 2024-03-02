class HourWeatherData {
  int? weatherId;
  double? temperature;
  double? humidity;
  double? pressure;
  double? rainfall;
  double? uvIndex;
  double? windSpeed;
  int? windDirection;
  double? airQualityIndex;
  double? coLevel;
  double? pm25;
  double? so2Level;
  double? no2Level;
  String? recordedTime;
  String? recordedDate;

  HourWeatherData({
    this.weatherId,
    this.temperature,
    this.humidity,
    this.pressure,
    this.rainfall,
    this.uvIndex,
    this.windSpeed,
    this.windDirection,
    this.airQualityIndex,
    this.coLevel,
    this.pm25,
    this.so2Level,
    this.no2Level,
    this.recordedTime,
    this.recordedDate,
  });

  factory HourWeatherData.fromJson(Map<String, dynamic> json) {
    return HourWeatherData(
      weatherId: json['Weather_id'],
      temperature: json['Temperature']?.toDouble() ?? 0.0,
      humidity: json['Humidity']?.toDouble() ?? 0.0,
      pressure: json['Pressure']?.toDouble() ?? 0.0,
      rainfall: json['Rainfall']?.toDouble() ?? 0.0,
      uvIndex: json['UV_Index']?.toDouble() ?? 0.0,
      windSpeed: json['Wind_Speed']?.toDouble() ?? 0.0,
      windDirection: json['Wind_Direction'] ?? 0,
      airQualityIndex: json['Air_Quality_Index']?.toDouble() ?? 0.0,
      coLevel: json['CO_Level']?.toDouble() ?? 0.0,
      pm25: json['PM2.5']?.toDouble() ?? 0.0,
      so2Level: json['SO2_Level']?.toDouble() ?? 0.0,
      no2Level: json['NO2_Level']?.toDouble() ?? 0.0,
      recordedTime: json['Recorded_Time'] ?? '',
      recordedDate: json['Recorded_Date'] ?? '',
    );
  }
}
