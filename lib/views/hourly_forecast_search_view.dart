import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_yt/providers/border_gradient_provider.dart';
import 'package:weather_app_yt/providers/get_hourly_weather_by_city_provider.dart';
import 'package:weather_app_yt/providers/text_color_provider.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/utils/get_weather_icons.dart';

class HourlyForecastSearchView extends ConsumerWidget {
  final String cityName;
  const HourlyForecastSearchView({super.key, required this.cityName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyWeather = ref.watch(getHourlyWeatherByCityProvider(cityName));

    return hourlyWeather.when(
      data: (hourlyForecast) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: 12,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final forecast = hourlyForecast.list[index];

              // timezone offset (seconds)
              final cityOffset = hourlyForecast.city?.timezone ?? 0;

              // Local time calculate
              final localTime = DateTime.fromMillisecondsSinceEpoch(
                (forecast.dt + cityOffset) * 1000,
                isUtc: true,
              );

              // am/pm format
              final formattedHour = DateFormat(
                'h:mm a',
              ).format(localTime); // e.g. 2 PM

              return HourlyForcastTile(
                id: forecast.weather[0].id,
                hour: formattedHour,
                temp: forecast.main!.temp.round(),
                isActive: index == 0,
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () {
        return const Center(child: SpinKitFadingCircle(
          color: Colors.black54,
          itemCount: 12,

        ),);
      },
    );
  }
}

class HourlyForcastTile extends ConsumerWidget {
  const HourlyForcastTile({
    super.key,
    required this.id,
    required this.hour,
    required this.temp,
    required this.isActive,
  });

  final int id;
  final String hour;
  final int temp;
  final bool isActive;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(borderGradientProvider);
    final color = ref.watch(textColorProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 22, top: 12, bottom: 12, left: 6),
      child: Card(
        margin: const EdgeInsets.all(0),

        color: isActive
            ? const Color.fromARGB(255, 28, 90, 148)
            : AppColors.accentBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: isActive ? 10 : 0,
        shadowColor: Colors.black,

        child: ZoAnimatedGradientBorder(
          borderRadius: 20.0,
          borderThickness: isActive ? 5.0 : 0.0,
          glowOpacity: 0.0,
          gradientColor: isActive ? colors : [],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(getWeatherIcon(weatherCode: id), width: 50),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(hour, style: const TextStyle(color: AppColors.white)),
                    const SizedBox(height: 5),
                    Text('$temp°C', style: TextStyles.h3(color)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
