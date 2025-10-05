import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_yt/constants/text_styles.dart';
import 'package:weather_app_yt/extensions/datetime.dart';
import 'package:weather_app_yt/providers/text_color_provider.dart';
import 'package:weather_app_yt/providers/weekly_weather_provider.dart';
import 'package:weather_app_yt/views/gradient_container.dart';
import 'package:weather_app_yt/views/hourly_forecast_view.dart';
import 'package:weather_app_yt/views/weekly_forecastview.dart';

class ForecastScreen extends ConsumerWidget {
  const ForecastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(textColorProvider);
    return EasyRefresh(
      onRefresh: () {
        ref.invalidate(weeklyWeatherProvider);
      },
      child: Scaffold(
        body: GradientContainer(
          children: [
            Text(
              "Weekly Forecast Report",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Text("Today", style: TextStyles.h1(color)),
              trailing: Text(
                DateTime.now().dateTime,
                style: GoogleFonts.lato(fontSize: 15, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),

            const HourlyForecastView(),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: Text("Next Forecast", style: TextStyles.h1(color)),
              trailing: const Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),

            const WeeklyForecastview(),
          ],
        ),
      ),
    );
  }
}
