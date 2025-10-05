import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_yt/constants/text_styles.dart';
import 'package:weather_app_yt/extensions/datetime.dart';
import 'package:weather_app_yt/providers/border_gradient_provider.dart';
import 'package:weather_app_yt/providers/current_weather_provider.dart';
import 'package:weather_app_yt/providers/text_color_provider.dart';
import 'package:weather_app_yt/views/gradient_container.dart';
import 'package:weather_app_yt/views/hourly_forecast_view.dart';
import 'package:weather_app_yt/views/weather_info.dart';
import 'package:zo_animated_border/zo_animated_border.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(textColorProvider);
    final weather = ref.watch(currentWeatherProvider);
    final colors = ref.watch(borderGradientProvider);
    final hour = DateTime.now().hour;

    return Scaffold(
      body: EasyRefresh(
        resetAfterRefresh: true,
      onRefresh: () {
        ref.invalidate(currentWeatherProvider);

      },
        child: weather.when(
            data: (data) {
             return GradientContainer(
              children: [
             Column(
              children: [
               SizedBox(
                height: 70,
                 child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                  ),

                    color: Colors.transparent,
                   child: ZoAnimatedGradientBorder(

                    borderRadius: 20.0,
                    borderThickness: 5.0,

                    glowOpacity: 0.0,
                    gradientColor: colors,
                     child: ListTile(leading: Text(data.name,style: TextStyles.h1(color),),
                     trailing: Padding(
                       padding: const EdgeInsets.only(top: 5, bottom: 5),
                       child: Column(
                        spacing: 6,


                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Text("Feels Like", style: TextStyles.h3(color), textAlign: TextAlign.center,),

                          Text("${data.main.feelsLike}°C", style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,

                          ),),

                        ],
                       ),
                     )
                     ),
                   ),
                 ),
               ),
               const SizedBox(
                height: 40,
               ),
               Text(DateTime.now().dateTime, style: GoogleFonts.poppins(
                fontSize: 18,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold

               )),
               const SizedBox(
                height: 40,
               ),
               SizedBox(
                height: 240,
                child: hour >= 18 || hour < 6 ? Image.asset("assets/icons2/${data.weather[0].icon.replaceAll("n", "d")}.gif") :  Image.asset("assets/icons/${data.weather[0].icon.replaceAll("n", "d")}.gif"),
               ),

               const SizedBox(
                height: 30,
               ),


               Text(data.weather[0].description.toUpperCase(), style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
               ),),
               const SizedBox(
                height: 40,
               ),


              ],
             ),
             Divider(
              color: Colors.black,
              thickness: 3,
              radius: BorderRadius.circular(10.0),
             ),
            const  SizedBox(
              height: 10,
             ),
             WeatherInfo(
                weather: data,
               ),
               const SizedBox(
                height: 10,
               ),


         Divider(
              color: Colors.black,
              thickness: 3.0,
              radius: BorderRadius.circular(10.0),
             ),
             const SizedBox(
              height: 20,
             ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ Text("Today", style: TextStyles.h2(color)),
                  TextButton(
                    style: TextButton.styleFrom(

                  foregroundColor: const Color.fromARGB(255, 207, 207, 207)
                ),onPressed: () {}, child: const Text("View full forecast"))
                ],
               ),
               const SizedBox(
                height: 15,
               ),
               const HourlyForecastView(),
             ]);
          }, error: (error, stackTrace) {



            return Center(child: Text(error.toString()),);}, loading: () => const Center(child: SpinKitFadingCircle(
            color: Colors.black,
          ),)),
      ),
    );

  }
}