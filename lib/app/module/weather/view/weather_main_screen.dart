import 'package:flutter/material.dart';
import 'package:weather_assesment/app/core/values/app_colors.dart';
import 'package:weather_assesment/app/core/values/app_values.dart';
import 'package:weather_assesment/app/core/values/extention.dart';
import 'package:weather_assesment/app/core/values/style_sheet.dart';
import 'package:weather_assesment/app/core/values/text_style.dart';
import 'package:weather_assesment/app/module/weather/controller/weather_view_model.dart';
import 'package:weather_assesment/app/module/weather/widget/box_tile.dart';
import 'package:weather_assesment/app/module/weather/widget/capsule_widget.dart';
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
    await Provider.of<WeatherViewModel>(context, listen: false).getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: appBgBoxDecorationStyle,
              //          child: Image.asset(
              //   'assets/images/weather_bg.png',
              //   fit: BoxFit.cover,
              //   height: height,
              //   width: width,
              // )
            ),
            Column(
              children: [
                _cityName(),
                _currrentLocationWidget(),
                Consumer<WeatherViewModel>(
                    builder: (context, viewModel, child) {
                  var data = viewModel.weatherData;
                  return data != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                          ],
                        )
                      : const CircularProgressIndicator(
                          color: AppColors.appBarColor,
                        );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _cityName() => Consumer<WeatherViewModel>(
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20, 0, 15).r,
            child: Text(
              viewModel.cityName!,
              style: context.appThemeText.displayLarge,
            ),
          );
        },
      );

  Widget _currrentLocationWidget() => Builder(builder: (context) {
        return InkWell(
          onTap: () => _getSevenDaysWeatherList(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.gps_fixed),
              Padding(
                padding: const EdgeInsets.all(AppValues.halfPadding).r,
                child: Text(context.lanValue.currentLocation),
              )
            ],
          ),
        );
      });

  Widget dailyForecast(List<DailyUIModel> forecastList) => SizedBox(
        height: AppValues.height_200.h,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecastList.length,
          itemBuilder: (context, index) {
            return _paddingSymHozt(
              AppValues.halfPadding,
              CapsuleWidget(
                needDot: index == 0,
                day: forecastList[index].day,
                icon: forecastList[index].weatherIcon,
                temp: "${forecastList[index].dayTemperature!.round()}°",
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
                child: Image.network(
              icon,
              fit: BoxFit.fill,
            )),
          ),
          SizedBox(width: 25.w),
          Text(
            '$temp°',
            style: headlineLargeTextStyle.copyWith(fontSize: 80),
          )
        ],
      );

  Widget _bottomStatusColumn(WeatherUIModel weatherData) =>
      Builder(builder: (context) {
        return Column(
          children: [
            //CapsuleWidget(day: 'Today', icon: '', temp: '30'),
            BoxTile(
              firstTitle: context.lanValue.sunRise,
              firstDesc: weatherData.sunrise,
              secondTitle: context.lanValue.sunSet,
              secondDesc: weatherData.sunset,
            ),
            BoxTile(
              firstTitle: context.lanValue.feelsLike,
              firstDesc: weatherData.feelsLike,
            )
          ],
        );
      });

  Widget _paddingSymHozt(padding, child) => Padding(
      padding: EdgeInsets.symmetric(horizontal: padding).r, child: child);
}
