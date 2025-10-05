

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_yt/models/weather.dart';
import 'package:weather_app_yt/services/api_helper.dart';


final getWeatherByCityProvider = FutureProvider.autoDispose.family<Weather, String>((ref, cityName) async {
  return ApiHelper().getWeatherByCityName(cityName: cityName);
});