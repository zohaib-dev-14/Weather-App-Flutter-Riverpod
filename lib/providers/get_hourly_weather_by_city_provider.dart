


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_yt/models/hourly_forecast_weather.dart';
import 'package:weather_app_yt/services/api_helper.dart';

final getHourlyWeatherByCityProvider = FutureProvider.autoDispose.family<HourlyForecast, String>((ref, cityName) async{
  return await ApiHelper().getHourlyForecastByCityName(cityName: cityName);
});