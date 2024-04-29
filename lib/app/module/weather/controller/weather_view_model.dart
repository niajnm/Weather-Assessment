import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_craft/app/core/services/service_locator.dart';
import 'package:flutter_craft/app/core/values/image_values.dart';
import 'package:flutter_craft/app/core/values/localization_helpers.dart';
import 'package:flutter_craft/app/data/remote/weather/model/weather_params.dart';
import 'package:flutter_craft/app/data/remote/weather/model/weather_response_model.dart';
import 'package:flutter_craft/app/data/repository/weather/weather_repository.dart';
import 'package:flutter_craft/app/module/weather/ui_model/weather_ui_model%20copy.dart';
import 'package:flutter_craft/app/module/weather/ui_model/weather_ui_model.dart';
import 'package:flutter_craft/app/utils/location/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _weatherRepository = serviceLocator<WeatherRepository>();

  // translateText(String? text, BuildContext context) async {
  //   final String currentLocale = Localizations.localeOf(context).languageCode;

  //   if (currentLocale == 'bn') {
  //     final translator = GoogleTranslator();
  //     var translation = await translator.translate(text ?? 'Loading', to: 'bn');
  //     return translation.text.toString();
  //   }

  //   return text;
  // }

  WeatherUIModel? weatherData;

  getWeather() async {
      var queryParams = WeatherParams(lat: '45.7567', lon: '126.6424');
  //  var queryParams = WeatherParams(lat: '${LocationService().getLat}', lon: '${LocationService().getLon}');
// WeatherParams(lat: currentLat.toString(), lon: currentLon.toString());
    WeatherResponseModel response =
        await _weatherRepository.getSevenDaysWeather(queryParams);
    WeatherUIModel weatherUIModel =
        WeatherUIModel.fromWeatherResponse(response);

    weatherData = weatherUIModel;

    notifyListeners();

    log('waether api called ');
    log('  waether${response.current!.temp}');
  }

  //   "${ImageValues.weather_image_url}${data.current!.weather?[0].icon}@2x.png"),

  WeatherUIModel convertToUIModel(WeatherResponseModel response) {
    final currentWeatherIcon = response.current?.weather?[0].icon;

    String? currentWeatherUrl =
        "${ImageValues.weather_image_url}$currentWeatherIcon@2x.png";

    String? iconPrefix = ImageValues.weather_image_url;

    return WeatherUIModel(
      latitude: response.lat,
      longitude: response.lon,
      timezone: response.timezone,
      timezoneOffset: response.timezoneOffset,
      currentTemperature: response.current!.temp.round().toString() + '',
      currentWeatherDescription: response.current?.weather?.first.description,
      currentWeatherIcon: currentWeatherUrl,
      dailyForecasts: response.daily?.map((daily) {
        return DailyUIModel(
          // date: DateTime.fromMillisecondsSinceEpoch((daily.dt ?? 0) * 1000),
          dayTemperature: daily.temp?.day,
          day: formatWeekDayName(daily.dt),
          weatherDescription: daily.weather?.first.description,
          weatherIcon:
              "${ImageValues.weather_image_url}${daily.weather!.first.icon}@2x.png",
        );
      }).toList(),
    );
  }

  // Future<bool> requestLocationPermission() async {
  //   var position = await LocationService.getCurrentLocation();
  //   final PermissionStatus permissionStatus = await Permission.location.status;
  //   if (permissionStatus.isGranted || permissionStatus.isLimited) {
  //     _setCurrentLocation(position.latitude, position.longitude);
  //     return true;
  //   }
  //   return false;
  // }

  // Future<bool> isLocationServiceAvailable() async {
  //   final PermissionStatus permissionStatus = await Permission.location.status;

  //   if (permissionStatus.isGranted) {
  //     log("Location access granted");
  //     try {
  //       final Position position = await LocationService.getCurrentLocation();
  //       if (position != null) {
  //         _setCurrentLocation(position.latitude, position.longitude);
  //         return true;
  //       }
  //     } catch (e) {
  //       log("Error getting current location: $e");
  //     }
  //   } else {
  //     log("Location access denied");
  //   }

  //   return false;
  // }

  // var _currentLat;
  // var _currentLon;

  // void _setCurrentLocation(Lat, Lon) {
  //   _currentLat = Lat;
  //   _currentLon = Lon;
  // }

  // double get getLat => _currentLat;

  // double get getLon => _currentLon;
}
