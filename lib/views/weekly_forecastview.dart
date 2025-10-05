import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_yt/constants/app_colors.dart';
import 'package:weather_app_yt/extensions/datetime.dart';
import 'package:weather_app_yt/providers/border_gradient_provider.dart';
import 'package:weather_app_yt/providers/weekly_weather_provider.dart';
import 'package:weather_app_yt/utils/get_weather_icons.dart';
import 'package:weather_app_yt/widgets/superscript_text.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class WeeklyForecastview extends ConsumerWidget {
  const WeeklyForecastview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weeklyForecast = ref.watch(weeklyWeatherProvider);
    return weeklyForecast.when(
      data: (weeklyWeather) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 18,
            mainAxisSpacing: 15,
          ),

          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: weeklyWeather.daily.weatherCode.length,
          itemBuilder: (context, index) {
            final dayOfWeek = DateTime.parse(
              weeklyWeather.daily.time[index],
            ).dayOfWeek;
            final date = weeklyWeather.daily.time[index];
            final temp = weeklyWeather.daily.temperature2mMax[index];
            final icon = weeklyWeather.daily.weatherCode[index];


            return WeeklyWeatherTile(
              date: date,
              day: dayOfWeek,
              temp: temp,
              icon: icon,
            );
          },
        );
      },
      error: (error, stackTrace) => Center(child: Text(stackTrace.toString())),
      loading: () {
        return const Center(
          child: SpinKitFadingCircle(color: Colors.black54, itemSize: 12),
        );
      },
    );
  }
}

class WeeklyWeatherTile extends ConsumerWidget {
  const WeeklyWeatherTile({
    super.key,
    required this.day,
    required this.date,
    required this.temp,
    required this.icon,
  });
  final String day;
  final String date;
  final double temp;
  final int icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parsedDate = DateTime.parse(date); // String -> DateTime
    final formattedDate = DateFormat("MMM d, y").format(parsedDate);

    final colors = ref.watch(borderGradientProvider);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 20,
      shadowColor: Colors.black,

      color: AppColors.accentBlue,

      child: ZoAnimatedGradientBorder(
        borderRadius: 20.0,
        borderThickness: 5.0,

        glowOpacity: 0.0,
        gradientColor: colors,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
            bottom: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                day,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                formattedDate,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              SuperscriptText(
                text: temp.toString(),
                color: AppColors.white,
                superScript: "°C",
                superScriptColor: AppColors.grey,
              ),
              const SizedBox(height: 20),
              SizedBox(height: 51, child: Image.asset(getWeatherIcon2(icon))),
            ],
          ),
        ),
      ),
    );
  }
}
