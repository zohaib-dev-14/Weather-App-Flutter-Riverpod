

import 'package:dio/dio.dart';

import 'package:weather_app_yt/constants/constants.dart';
import 'package:weather_app_yt/models/geo_locator.dart';
import 'package:weather_app_yt/models/hourly_forecast_weather.dart' hide Weather;
import 'package:weather_app_yt/models/hourly_weather.dart';
import 'package:weather_app_yt/models/weather.dart';
import 'package:weather_app_yt/models/weekly_weather.dart';
import 'package:weather_app_yt/services/geolocator.dart';
import 'package:weather_app_yt/utils/logging.dart';

class ApiHelper {
    final String baseUrl = "https://api.openweathermap.org/data/2.5";
    final String weeklyWeatherUrl = "https://api.open-meteo.com/v1/";
    final String baseLocationUrl = "https://geocoding-api.open-meteo.com/v1";


    double latitude = 0.0;
    double longitude = 0.0;

  final dio = Dio();

  //& function to fetch location of current device
   Future<void> fetchLocation() async {
     final location = await getLocation();
     latitude = location.latitude;
     longitude = location.longitude;
  }

    Future<Weather> getCurrentWeather() async {
    await fetchLocation();
    final url = _constructWeatherUrl();
    final responseData = await _fetchData(url);
    return Weather.fromJson(responseData);
  }
  Future<HourlyWeather> getHourlyForecast() async {
    await fetchLocation();
    final url = _constructForecastUrl();
    final responseData = await _fetchData(url);
    return HourlyWeather.fromJson(responseData);
  }

  Future<HourlyForecast> getHourlyForecastByCityName({required String cityName}) async {
    final url = _constructForecastByCityUrl(cityName);
    final responseData = await _fetchData(url);
    return HourlyForecast.fromJson(responseData);
  }



  Future<WeeklyWeather> getWeeklyWeather() async {
    await fetchLocation();
   final url = _constructWeeklyForecastUrl();
   final responseData = await _fetchData(url);
   return WeeklyWeather.fromJson(responseData);
  }


  Future<Weather> getWeatherByCityName({required String cityName}) async {
    final url = _constructWeatherByCityUrl(cityName);
    final responseData = await _fetchData(url);
    return Weather.fromJson(responseData);
  }



  double? _latitudeOfApi;
  double? _longitudeOfApi;

  Future<WeeklyWeather> getWeeklyWeatherByPoints({required String cityName}) async {

    final url = _constructFetchLocationUrl(cityName);
    final responseData = await _fetchData(url);
    final geoLocator = GeoLocator.fromJson(responseData);
     _latitudeOfApi = geoLocator.results?.first.latitude;
      _longitudeOfApi = geoLocator.results?.first.longitude;



final url1 = _constructWeeklyForecastByPoints();
    final responseData1 = await _fetchData(url1);
    return WeeklyWeather.fromJson(responseData1);

  }




   String _constructWeeklyForecastByPoints() => "$weeklyWeatherUrl/forecast?latitude=$_latitudeOfApi&longitude=$_longitudeOfApi&daily=temperature_2m_max,temperature_2m_min,weathercode&forecast_days=7&timezone=auto";




   String _constructWeatherUrl() => "$baseUrl/weather?lat=$latitude&lon=$longitude&units=metric&appid=${Constants.apiKey}";



   String _constructForecastUrl() => "$baseUrl/forecast?lat=$latitude&lon=$longitude&units=metric&appid=${Constants.apiKey}";

     String _constructWeeklyForecastUrl() => "$weeklyWeatherUrl/forecast?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min,weathercode&forecast_days=7&timezone=auto";


   String _constructWeatherByCityUrl(String cityName) => "$baseUrl/weather?q=$cityName&units=metric&appid=${Constants.apiKey}";


   String _constructForecastByCityUrl(String cityName) => "$baseUrl/forecast?q=$cityName&units=metric&appid=${Constants.apiKey}";



   String _constructFetchLocationUrl(String cityName) => "$baseLocationUrl/search?name=$cityName&count=10&language=en&format=json";


    Future<Map<String, dynamic>> _fetchData(String url) async {
    try {
       final response = await dio.get(url);

      if (response.statusCode == 200) {
        return await response.data;
      }
      else {
        throw Exception("Error fetching data");
      }

    } catch (e) {
      printWarning("Error fetching data from $url and error $e");
      throw Exception(e.toString());
    }
  }

}


