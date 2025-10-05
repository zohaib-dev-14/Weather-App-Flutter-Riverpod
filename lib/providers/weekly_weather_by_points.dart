import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_yt/models/weekly_weather.dart';
import 'package:weather_app_yt/services/api_helper.dart';

final getWeeklyWeatherProviderByPoints = FutureProvider.autoDispose.family<WeeklyWeather, String>((ref, cityName) async {
  return ApiHelper().getWeeklyWeatherByPoints(cityName: cityName);
});