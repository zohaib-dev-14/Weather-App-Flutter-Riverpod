import 'package:flutter/foundation.dart' show immutable;

@immutable
class Weather {
  final Coord coord;
  final List<WeatherData> weather;
  final String base;
  final MainData main;
  final int visibility;
  final Wind wind;
  final Rain? rain;
  final Clouds clouds;
  final int dt;
  final Sys sys;
  final int timezone;
  final int id;
  final String name;
  final int cod;

  const Weather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    this.rain,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        coord: Coord.fromJson(json['coord']),
        weather: (json['weather'] as List)
            .map((e) => WeatherData.fromJson(e))
            .toList(),
        base: json['base'],
        main: MainData.fromJson(json['main']),
        visibility: json['visibility'] ?? 0,
        wind: Wind.fromJson(json['wind']),
        rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
        clouds: Clouds.fromJson(json['clouds']),
        dt: json['dt'],
        sys: Sys.fromJson(json['sys']),
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod'],
      );
}

@immutable
class Coord {
  final double lon;
  final double lat;

  const Coord({required this.lon, required this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: (json['lon'] as num).toDouble(),
        lat: (json['lat'] as num).toDouble(),
      );
}

@immutable
class WeatherData {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherData({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon'],
      );
}

@immutable
class MainData {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int? seaLevel;   // nullable
  final int? grndLevel;  // nullable

  const MainData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  factory MainData.fromJson(Map<String, dynamic> json) => MainData(
        temp: (json['temp'] as num).toDouble(),
        feelsLike: (json['feels_like'] as num).toDouble(),
        tempMin: (json['temp_min'] as num).toDouble(),
        tempMax: (json['temp_max'] as num).toDouble(),
        pressure: json['pressure'],
        humidity: json['humidity'],
        seaLevel: json['sea_level'] as int?,   // nullable safe parse
        grndLevel: json['grnd_level'] as int?, // nullable safe parse
      );
}


@immutable
class Wind {
  final double speed;
  final int deg;
  final double? gust; // nullable

  const Wind({
    required this.speed,
    required this.deg,
    this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: (json['speed'] as num).toDouble(),
        deg: json['deg'],
        gust: (json['gust'] as num?)?.toDouble(),
      );
}

@immutable
class Rain {
  final double? oneHour;

  const Rain({this.oneHour});

  // OpenWeather ke JSON me rain ka field "1h" hota hai, not "oneHour"
  factory Rain.fromJson(Map<String, dynamic> json) =>
      Rain(oneHour: (json['1h'] as num?)?.toDouble());
}

@immutable
class Clouds {
  final int all;

  const Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) =>
      Clouds(all: json['all']);
}

@immutable
class Sys {
  final String country;
  final int sunrise;
  final int sunset;

  const Sys({
    required this.country,
    required this.sunrise,
    required this.sunset,
  });

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json['country'],
        sunrise: json['sunrise'],
        sunset: json['sunset'],
      );
}
