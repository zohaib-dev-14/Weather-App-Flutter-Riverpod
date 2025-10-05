import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app_yt/constants/app_colors.dart';
import 'package:weather_app_yt/constants/text_styles.dart';
import 'package:weather_app_yt/extensions/datetime.dart';
import 'package:weather_app_yt/providers/border_gradient_provider.dart';
import 'package:weather_app_yt/providers/get_weather_by_city_provider.dart';
import 'package:weather_app_yt/providers/text_color_provider.dart';
import 'package:weather_app_yt/providers/weekly_weather_by_points.dart';
import 'package:weather_app_yt/views/gradient_container.dart';
import 'package:weather_app_yt/views/hourly_forecast_search_view.dart';
import 'package:weather_app_yt/views/weather_info.dart';
import 'package:weather_app_yt/views/weekly_forecast_search_view.dart';
import 'package:zo_animated_border/zo_animated_border.dart';




class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String? cityName;

  void _searchCity() {
    setState(() {
      cityName = _controller.text.trim();
    });
  }




  @override
  Widget build(BuildContext context)  {
    final weatherAsync = cityName == null ? null : ref.watch(getWeatherByCityProvider(cityName!));
    final weeklyWeatherAsync = cityName == null ? null :  ref.watch(getWeeklyWeatherProviderByPoints(cityName!));
    final color = ref.watch(textColorProvider);
    final hour = DateTime.now().hour;



    final colors = ref.watch(borderGradientProvider);
    return Scaffold(
      body: EasyRefresh(


         onRefresh: () {
          ref.invalidate(getWeatherByCityProvider);
        },
        child: GradientContainer(children: [
          Row(
            children: [
              Expanded(child: Card(

            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            color: AppColors.white,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(

                contentPadding: EdgeInsets.all(15.0),
                hintText: "Enter a city name",
                border: InputBorder.none,
               prefixIcon: Icon(Icons.search),

              ),
            ),
          ),),
          const SizedBox(
            width: 10,
          ),

          GestureDetector(
            onTap: _searchCity,
            child: Card(
              color: Colors.white,

              elevation: 10,
              child:  Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                height: 53,
                width: 60,
                alignment: Alignment.center,
                child: Text("Enter", style: GoogleFonts.poppins(),)),

            ),
          )

            ],
          ),
         const SizedBox(
            height: 40,
          ),


          if (weatherAsync != null)
          weatherAsync.when(data: (data) {
            return  Column(

              children: [

                AspectRatio(
                  aspectRatio: 4.6,
                  child: Card(
                                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                                ),

                  color: Colors.transparent,
                                 child: ZoAnimatedGradientBorder(

                  borderRadius: 20.0,
                  borderThickness: 3.0,

                  glowOpacity: 0.0,
                  gradientColor: colors,
                   child: ListTile(leading: Text(data.name,style: TextStyles.h1(color)),
                   trailing: Padding(
                     padding: const EdgeInsets.only(top: 8),
                     child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text("Feels Like", style: TextStyles.h3(color),),
                        const SizedBox(
                          height: 8,
                        ),
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
              fontSize: 15,
              color: const Color.fromARGB(255, 255, 255, 255)

             )),
           const SizedBox(
            height: 30,
           ),
           SizedBox(
            height: 240,
            child:  hour >= 18 || hour < 6 ? Image.asset("assets/icons2/${data.weather[0].icon.replaceAll("n", "d")}.gif") :  Image.asset("assets/icons/${data.weather[0].icon.replaceAll("n", "d")}.gif"),
           ),

           const SizedBox(
            height: 40,
           ),


           Text(data.weather[0].description.toUpperCase(), style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white
           ),),

           const SizedBox(
            height: 40,
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
              thickness: 3,
              radius: BorderRadius.circular(10.0),
             ),

           const SizedBox(
            height: 40,
           ),


           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text("Today", style: TextStyles.h2(color)),
              TextButton(
                style: TextButton.styleFrom(

                  foregroundColor: const Color.fromARGB(255, 207, 207, 207)
                ),
                onPressed: () {}, child: const Text("View full forecast"))
            ],
           ),
           const SizedBox(
            height: 15,
           ),
            HourlyForecastSearchView(
              cityName:  _controller.text
            ),


              ],
            );

          }, error: (error, stackTrace) =>  Center(child: _controller.text.isEmpty ? const Text("field should not empty") : error.toString().contains("Socket") ? const Text("No internet connection") :  Text(stackTrace.toString()),), loading: () => const Center(
            child: SpinKitFadingCircle(
              color: Colors.black,
              itemCount: 12,
            ),
          )),

          if (weeklyWeatherAsync != null)
          weeklyWeatherAsync.maybeWhen(
            data: (data) {
              return Column(
              children: [
                 const SizedBox(
            height: 20,
           ),
           ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: Text("Weekly Forecast", style: TextStyles.h1(color),),
            trailing: const Icon(Icons.calendar_month_outlined, color: Colors.white,),
          ),
          const SizedBox(
            height: 25,
          ),
                WeeklyForecastSearchview(
                  cityName: cityName,
                ),
              ],
            );
            },
            orElse: () => const SizedBox())



        ]),
      ),
    );
  }
}