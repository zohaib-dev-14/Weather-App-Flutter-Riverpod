class WeeklyWeather {
  final double latitude;
  final double longitude;
  final double generationtimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final DailyUnits dailyUnits;
  final Daily daily;

  WeeklyWeather({
    required this.latitude,
    required this.longitude,
    required this.generationtimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.dailyUnits,
    required this.daily,
  });

  factory WeeklyWeather.fromJson(Map<String, dynamic> json) => WeeklyWeather(
    latitude: (json["latitude"] ?? 0.0).toDouble(),
    longitude: (json["longitude"] ?? 0.0).toDouble(),
    generationtimeMs: (json["generationtime_ms"] ?? 0.0).toDouble(),
    utcOffsetSeconds: json["utc_offset_seconds"] ?? 0,
    timezone: json["timezone"] ?? "",
    timezoneAbbreviation: json["timezone_abbreviation"] ?? "",
    elevation: (json["elevation"] ?? 0.0).toDouble(),
    dailyUnits: DailyUnits.fromJson(json["daily_units"]),
    daily: Daily.fromJson(json["daily"]),
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "generationtime_ms": generationtimeMs,
    "utc_offset_seconds": utcOffsetSeconds,
    "timezone": timezone,
    "timezone_abbreviation": timezoneAbbreviation,
    "elevation": elevation,
    "daily_units": dailyUnits.toJson(),
    "daily": daily.toJson(),
  };
}

class DailyUnits {
  final String time;
  final String temperature2mMax;
  final String temperature2mMin;
  final String weatherCode;

  DailyUnits({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.weatherCode,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
    time: json["time"] ?? "",
    temperature2mMax: json["temperature_2m_max"] ?? "",
    temperature2mMin: json["temperature_2m_min"] ?? "",
    weatherCode: json["weathercode"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "temperature_2m_max": temperature2mMax,
    "temperature_2m_min": temperature2mMin,
    "weathercode": weatherCode,
  };
}

class Daily {
  final List<String> time;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<int> weatherCode;

  Daily({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.weatherCode,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    time: List<String>.from(json["time"].map((x) => x)),
    temperature2mMax: List<double>.from(
      json["temperature_2m_max"].map((x) => (x as num).toDouble()),
    ),
    temperature2mMin: List<double>.from(
      json["temperature_2m_min"].map((x) => (x as num).toDouble()),
    ),
    weatherCode: List<int>.from(json["weathercode"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "time": List<dynamic>.from(time.map((x) => x)),
    "temperature_2m_max": List<dynamic>.from(temperature2mMax.map((x) => x)),
    "temperature_2m_min": List<dynamic>.from(temperature2mMin.map((x) => x)),
    "weathercode": List<dynamic>.from(weatherCode.map((x) => x)),
  };
}
