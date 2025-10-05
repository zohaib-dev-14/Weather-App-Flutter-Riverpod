import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_yt/constants/text_styles.dart';
import 'package:weather_app_yt/extensions/double.dart';
import 'package:weather_app_yt/models/weather.dart';
import 'package:weather_app_yt/providers/text_color_provider.dart';

class WeatherInfo extends StatelessWidget {
  final Weather weather;
  const WeatherInfo({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherInfoTile(
            title: "Temp",
            value: "${weather.main.temp}°C"
          ),


          WeatherInfoTile(
            title: "Wind",
            value: "${weather.wind.speed.kmh} km/h"
          ),

          WeatherInfoTile(
            title: "Humidity",
            value: "${weather.main.humidity}%"
          ),
        ],
      ),
    );
  }
}


class WeatherInfoTile extends ConsumerWidget {
  final String title;
  final String value;
  const WeatherInfoTile({super.key, required this. title, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(textColorProvider);
    return Column(
      children: [
        Text(title, style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w500
        ),),
        const SizedBox(
          height: 10,
        ),
        Text(value, style: TextStyles.h3(color),)

      ],
    );
  }
}