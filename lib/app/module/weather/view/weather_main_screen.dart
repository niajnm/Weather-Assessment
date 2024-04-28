import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_craft/app/core/values/extention.dart';
import 'package:flutter_craft/app/core/values/image_values.dart';
import 'package:flutter_craft/app/core/values/style_sheet.dart';
import 'package:flutter_craft/app/data/remote/weather/model/weather_response_model.dart';
import 'package:flutter_craft/app/module/weather/ui_model/weather_ui_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_craft/app/core/values/text_style.dart';
import 'package:flutter_craft/app/module/weather/controller/weather_view_model.dart';
import 'package:flutter_craft/app/module/weather/widget/box_tile.dart';
import 'package:flutter_craft/app/module/weather/widget/capsule_widget.dart';
import 'package:flutter_craft/app/module/weather/widget/froster_glass.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({super.key});

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  @override
  void initState() {
    super.initState();
    _getSevenDaysWeatherList();
  }

  _getSevenDaysWeatherList() async {
    // double currentLat =
    //     Provider.of<HomeViewModel>(context, listen: false).getLat();
    // double currentLon =
    //     Provider.of<HomeViewModel>(context, listen: false).getLon();

    await Provider.of<WeatherViewModel>(context, listen: false).getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          Expanded(child: Container(decoration: appBgBoxDecorationStyle)),
          Consumer<WeatherViewModel>(builder: (context, viewModel, child) {
            var data = viewModel.weatherData;

            return data != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 20, 0, 15).r,
                          child: Text(
                            context.lanValue!.info,
                            style: context.appThemeText.displayLarge,
                            //style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.gps_fixed),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Current Location'),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            _weatherTempSec(data.currentTemperature!,
                                data.currentWeatherIcon),
                            Text(
                              'Party cloud',
                              style: bodyLargeTextStyleDark,
                            ),

                            dailyForecast(data.dailyForecasts!),

                            //  CapsuleWidget(day: 'Today', icon: '', temp: '30'),
                            // BoxTile(
                            //   firstTitle: 'Sunset',
                            //   firstDesc: '5:52 pm',
                            //   secondTitle: 'Sunrise',
                            //   secondDesc: '7:00AM',
                            // ),
                            // BoxTile(
                            //   firstTitle: 'Sunset',
                            //   firstDesc: '5:52 pm',
                            // )
                          ],
                        )
                      ])
                : const CircularProgressIndicator();
          })
        ],
      ),
    );
  }

  Widget dailyForecast(List<DailyUIModel> forecastList) => SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecastList
              .length, // Example: Replace with the actual number of items
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CapsuleWidget(
                day: forecastList[index].day, // Replace with the actual day
                icon: forecastList[index]
                    .weatherIcon, // Replace with the actual icon URL or icon data
                temp: forecastList[index]
                    .dayTemperature
                    .toString(), // Replace with the actual temperature
              ),
            );
          },
        ),
      );

  Widget _weatherTempSec(temp, icon) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120.h,
            width: 120.w,
            child: ClipRRect(
                // borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
              icon,
              fit: BoxFit.fill,
              //   color: context.resources.colors.error,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Text(
              temp.toString(),
              style: headlineLargeTextStyle.copyWith(fontSize: 80),
            ),
          )
        ],
      );
}
