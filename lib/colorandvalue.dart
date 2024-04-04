import 'package:flutter/material.dart';

// Function to determine color and situation based on CO concentration
Map<String, dynamic> getColorAndSituationForCO(double value) {
  if (value >= 0 && value <= 4.4) {
    return {"color": Colors.green, "situation": "Good"}; // Good
  } else if (value <= 9.4) {
    return {"color": Colors.yellow, "situation": "Moderate"}; // Moderate
  } else if (value <= 12.4) {
    return {
      "color": Colors.orange,
      "situation": "Unhealthy for Sensitive Groups"
    }; // Unhealthy for Sensitive Groups
  } else if (value <= 15.4) {
    return {"color": Colors.red, "situation": "Unhealthy"}; // Unhealthy
  } else if (value <= 30.4) {
    return {
      "color": Colors.purple,
      "situation": "Very Unhealthy"
    }; // Very Unhealthy
  } else {
    return {"color": Colors.black, "situation": "Hazardous"}; // Hazardous
  }
}

// Function to determine color and situation based on SO2 concentration
Map<String, dynamic> getColorAndSituationForSO2(double value) {
  if (value >= 0 && value <= 35) {
    return {"color": Colors.green, "situation": "Good"}; // Good
  } else if (value <= 75) {
    return {"color": Colors.yellow, "situation": "Moderate"}; // Moderate
  } else if (value <= 185) {
    return {
      "color": Colors.orange,
      "situation": "Unhealthy for Sensitive Groups"
    }; // Unhealthy for Sensitive Groups
  } else if (value <= 304) {
    return {"color": Colors.red, "situation": "Unhealthy"}; // Unhealthy
  } else if (value <= 604) {
    return {
      "color": Colors.purple,
      "situation": "Very Unhealthy"
    }; // Very Unhealthy
  } else {
    return {"color": Colors.black, "situation": "Hazardous"}; // Hazardous
  }
}

// Function to determine color and situation based on NO2 concentration
Map<String, dynamic> getColorAndSituationForNO2(double value) {
  if (value >= 0 && value <= 53) {
    return {"color": Colors.green, "situation": "Good"}; // Good
  } else if (value <= 100) {
    return {"color": Colors.yellow, "situation": "Moderate"}; // Moderate
  } else if (value <= 360) {
    return {
      "color": Colors.orange,
      "situation": "Unhealthy for Sensitive Groups"
    }; // Unhealthy for Sensitive Groups
  } else if (value <= 649) {
    return {"color": Colors.red, "situation": "Unhealthy"}; // Unhealthy
  } else if (value <= 1249) {
    return {
      "color": Colors.purple,
      "situation": "Very Unhealthy"
    }; // Very Unhealthy
  } else {
    return {"color": Colors.black, "situation": "Hazardous"}; // Hazardous
  }
}

// Function to determine color and situation based on wind speed
Map<String, dynamic> getColorAndSituationForWindSpeed(double value) {
  if (value < 1.0) {
    return {"color": Colors.blue, "situation": "Calm"}; // Calm
  } else if (value <= 5.0) {
    return {
      "color": Colors.lightBlue,
      "situation": "Light Breeze"
    }; // Light Breeze
  } else if (value <= 11.0) {
    return {
      "color": Colors.green,
      "situation": "Moderate Breeze"
    }; // Moderate Breeze
  } else if (value <= 19.0) {
    return {
      "color": Colors.orange,
      "situation": "Fresh Breeze"
    }; // Fresh Breeze
  } else if (value <= 28.0) {
    return {"color": Colors.red, "situation": "Strong Breeze"}; // Strong Breeze
  } else {
    return {"color": Colors.deepOrange, "situation": "High Wind"}; // High Wind
  }
}

// Function to determine color and situation based on temperature
Map<String, dynamic> getColorAndSituationForTemperature(double value) {
  if (value < 0.0) {
    return {"color": Colors.blue, "situation": "Very Cold"}; // Very Cold
  } else if (value <= 10.0) {
    return {"color": Colors.lightBlue, "situation": "Cold"}; // Cold
  } else if (value <= 20.0) {
    return {"color": Colors.green, "situation": "Cool"}; // Cool
  } else if (value <= 25.0) {
    return {"color": Colors.orange, "situation": "Moderate"}; // Moderate
  } else if (value <= 30.0) {
    return {"color": Colors.red, "situation": "Warm"}; // Warm
  } else {
    return {"color": Colors.deepOrange, "situation": "Hot"}; // Hot
  }
}

// Function to determine color and situation based on AQI
Map<String, dynamic> getColorAndSituationForAQI(double value) {
  if (value >= 0 && value <= 50) {
    return {"color": Colors.green, "situation": "Good"}; // Good
  } else if (value <= 100) {
    return {"color": Colors.yellow, "situation": "Moderate"}; // Moderate
  } else if (value <= 200) {
    return {
      "color": Colors.orange,
      "situation": "Unhealthy"
    }; // Unhealthy for Sensitive Groups
  } else if (value <= 300) {
    return {"color": Colors.red, "situation": "Unhealthy"}; // Unhealthy
  } else if (value <= 400) {
    return {
      "color": Colors.purple,
      "situation": "Very Unhealthy"
    }; // Very Unhealthy
  } else {
    return {"color": Colors.black, "situation": "Hazardous"}; // Hazardous
  }
}

// Function to determine color and situation based on pressure
Map<String, dynamic> getColorAndSituationForPressure(double value) {
  if (value < 980.0) {
    return {"color": Colors.blue, "situation": "Low"}; // Low
  } else if (value <= 1010.0) {
    return {"color": Colors.green, "situation": "Normal"}; // Normal
  } else {
    return {"color": Colors.red, "situation": "High"}; // High
  }
}

// Function to determine color and situation based on UV index
Map<String, dynamic> getColorAndSituationForUV(double value) {
  if (value <= 2) {
    return {"color": Colors.green, "situation": "Low"}; // Low
  } else if (value <= 5) {
    return {"color": Colors.yellow, "situation": "Moderate"}; // Moderate
  } else if (value <= 7) {
    return {"color": Colors.orange, "situation": "High"}; // High
  } else if (value <= 10) {
    return {"color": Colors.red, "situation": "Very High"}; // Very High
  } else {
    return {"color": Colors.purple, "situation": "Extreme"}; // Extreme
  }
}

// Function to determine color and situation based on PM2.5 concentration
Map<String, dynamic> getColorAndSituationForPM25(double value) {
  if (value >= 0 && value <= 12) {
    return {"color": Colors.green, "situation": "Good"}; // Good
  } else if (value <= 35) {
    return {"color": Colors.yellow, "situation": "Moderate"}; // Moderate
  } else if (value <= 55) {
    return {
      "color": Colors.orange,
      "situation": "Unhealthy"
    }; // Unhealthy for Sensitive Groups
  } else if (value <= 150) {
    return {"color": Colors.red, "situation": "Unhealthy"}; // Unhealthy
  } else if (value <= 250) {
    return {
      "color": Colors.purple,
      "situation": "Very Unhealthy"
    }; // Very Unhealthy
  } else {
    return {"color": Colors.black, "situation": "Hazardous"}; // Hazardous
  }
}

// Function to determine color and situation based on humidity
Map<String, dynamic> getColorAndSituationForHumidity(double value) {
  if (value < 30) {
    return {"color": Colors.red, "situation": "Low"}; // Low
  } else if (value <= 60) {
    return {"color": Colors.green, "situation": "Normal"}; // Normal
  } else {
    return {"color": Colors.blue, "situation": "High"}; // High
  }
}

Map<String, dynamic> getColorAndSituationForRainfall(double value) {
  if (value == 0) {
    return {"color": Colors.green, "situation": "No Rainfall"}; // No Rainfall
  } else if (value <= 2.5) {
    return {
      "color": Colors.lightBlue,
      "situation": "Light Rainfall"
    }; // Light Rainfall
  } else if (value <= 7.6) {
    return {
      "color": Colors.blue,
      "situation": "Moderate Rainfall"
    }; // Moderate Rainfall
  } else if (value <= 15.0) {
    return {
      "color": Colors.orange,
      "situation": "Heavy Rainfall"
    }; // Heavy Rainfall
  } else {
    return {
      "color": Colors.red,
      "situation": "Very Heavy Rainfall"
    }; // Very Heavy Rainfall
  }
}
