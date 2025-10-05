import 'package:flutter/material.dart';
import 'package:weather_app_yt/screens/forecast_screen.dart';
import 'package:weather_app_yt/screens/search_screen.dart';
import 'package:weather_app_yt/screens/weather_screen.dart';

final screens = const [
     WeatherScreen(),
    SearchScreen(),
    ForecastScreen(),
    Center(
      child: Text("Settings"),
    ),
  ];


  final destinations = const [

   NavigationDestination(


    icon: Icon(Icons.home_outlined, color: Colors.white), label: "", selectedIcon: Icon(Icons.home, color: Colors.white, size: 35,), ),
   NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.search_outlined, color: Colors.white), label: "", selectedIcon: Icon(Icons.search, color: Colors.white, size: 35,),),
   NavigationDestination(icon: Icon(Icons.wb_sunny_outlined, color: Colors.white), label: "", selectedIcon: Icon(Icons.wb_sunny, color: Colors.white, size: 35,),),
   NavigationDestination(icon: Icon(Icons.settings_outlined, color: Colors.white), label: "", selectedIcon: Icon(Icons.settings, color: Colors.white, size: 35,),),

  ];