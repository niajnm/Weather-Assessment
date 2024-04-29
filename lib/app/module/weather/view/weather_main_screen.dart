import 'package:flutter/material.dart';
import 'package:flutter_craft/app/core/values/app_colors.dart';
import 'package:flutter_craft/app/core/values/app_values.dart';
import 'package:flutter_craft/app/core/values/extention.dart';
import 'package:flutter_craft/app/core/values/style_sheet.dart';
import 'package:flutter_craft/app/core/values/text_style.dart';
import 'package:flutter_craft/app/module/weather/controller/weather_view_model.dart';
import 'package:flutter_craft/app/module/weather/widget/box_tile.dart';
import 'package:flutter_craft/app/module/weather/widget/capsule_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../ui_model/weather_ui_model copy.dart';

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
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          Expanded(
              child: Container(decoration: appBgBoxDecorationStyle
                  //          child: Image.asset(
                  //   'assets/images/weather_bg.png',
                  //   fit: BoxFit.cover,
                  //   height: height,
                  //   width: width,
                  // )
                  )),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                      bottom: AppValues.basePadding)
                                  .r,
                              child: Text(
                                data.currentWeatherDescription.toString(),
                                style: context.appThemeText.displayMedium,
                              ),
                            ),
                            dailyForecast(data.dailyForecasts!),
                            _bottomStatusColumn(data)

                            // CustomPaint(
                            //   size: Size(
                            //       width,
                            //       (width * 0.5833333333333334)
                            //           .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                            //   painter: RPSCustomPainter(),
                            // ),
                          ],
                        )
                      ])
                : const CircularProgressIndicator(
                    color: AppColors.appBarColor,
                  );
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
                needDot: index == 0,
                day: forecastList[index].day, // Replace with the actual day
                icon: forecastList[index]
                    .weatherIcon, // Replace with the actual icon URL or icon data
                temp:
                    "${forecastList[index].dayTemperature!.round()}°", // Replace with the actual temperature
              ),
            );
          },
        ),
      );

  Widget _weatherTempSec(temp, icon) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 130.h,
            width: 130.w,
            child: ClipRRect(
                // borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
              icon,
              fit: BoxFit.fill,
              //   color: context.resources.colors.error,
            )),
          ),
          SizedBox(width: 25.w),
          Text(
            '$temp°',
            style: headlineLargeTextStyle.copyWith(fontSize: 80),
          )
        ],
      );

  Widget _bottomStatusColumn(WeatherUIModel weatherData) => Column(
        children: [
          //CapsuleWidget(day: 'Today', icon: '', temp: '30'),
          BoxTile(
            firstTitle: 'Sunrise',
            firstDesc: weatherData.sunrise,
            secondTitle: 'Sunset',
            secondDesc: weatherData.sunset,
          ),
          BoxTile(
            firstTitle: 'Feels Like',
            firstDesc: weatherData.feelsLike,
          )
        ],
      );
}
