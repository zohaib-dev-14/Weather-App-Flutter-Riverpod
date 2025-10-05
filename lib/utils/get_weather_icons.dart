String getWeatherIcon({
  required int weatherCode,
}) {
  String weatherCondition = '01d';

  if (weatherCode == 801) {
    weatherCondition = 'assets/icons/02d.gif';
  } else if (weatherCode == 802) {
    weatherCondition = 'assets/icons/03d.gif';
  } else if (weatherCode == 803) {
    weatherCondition = 'assets/icons/04d.gif';
  } else if (weatherCode == 804) {
    weatherCondition = 'assets/icons/04d.gif';
  } else if (weatherCode == 800) {
    weatherCondition = 'assets/icons/01d.gif';
  } else if (weatherCode > 700) {
    weatherCondition = 'assets/icons/50d.gif';
  } else if (weatherCode >= 600) {
    weatherCondition = 'assets/icons/13d.gif';
  } else if (weatherCode >= 500) {
    weatherCondition = 'assets/icons/10d.gif';
  } else if (weatherCode >= 300) {
    weatherCondition = 'assets/icons/09d.gif';
  } else if (weatherCode >= 200) {
    weatherCondition = 'assets/icons/11d.gif';
  }

  return weatherCondition;
}

//! Mpas weather codes (from opne-meteo) to image urls
String getWeatherIcon2(int id) {
  if (id == 0) {
    return 'assets/icons/01d.gif';
  }
  if (id == 1) {
    return 'assets/icons/6.gif';
  }
  if (id == 2) {
    return 'assets/icons/03d.gif';
  }
  if (id == 3) {
    return 'assets/icons/04d.gif';
  }
  if (id == 45) {
    return 'assets/icons/04d.gif';
  }
  if (id == 48) {
    return 'assets/icons/04d.gif';
  }
  if (id == 53) {
    return 'assets/icons/39.gif';
  }
  if (id > 50 && id < 60) {
    return 'assets/icons/09d.gif';
  }
  if (id > 60 && id < 70) {
    return 'assets/icons/7.gif';
  }
  if (id >= 70 && id < 80) {
    return 'assets/icons/04d.gif';
  }
  if (id >= 80 && id < 85) {
    return 'assets/icons/7.gif';
  }
  if (id > 85) {
    return 'assets/icons/13d.gif';
  }

  return 'assets/icons/01d.gif';
}



/*

0: Clear sky
1: Mainly clear
2: Partly cloudy
3: Overcast
45: Fog
48: Depositing rime fog
51: Light drizzle
52: Moderate drizzle
53: Heavy drizzle
55: Freezing drizzle
56: Light freezing drizzle
57: Heavy freezing drizzle
61: Slight rain
63: Moderate rain
65: Heavy rain
66: Light freezing rain
67: Heavy freezing rain
71: Slight snowfall
73: Moderate snowfall
75: Heavy snowfall
77: Ice pellets
80: Light rain showers
81: Moderate rain showers
82: Violent rain showers
85: Light snow showers
86: Moderate snow showers
87: Violent snow showers

*/