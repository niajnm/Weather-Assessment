import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:weather_assesment/app/core/services/service_locator.dart';
import 'package:weather_assesment/app/core/values/image_values.dart';
import 'package:weather_assesment/app/core/values/localization_helpers.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
import 'package:weather_assesment/app/data/repository/weather_repository/weather_repository.dart';
import 'package:weather_assesment/app/module/weather/ui_model/weather_ui_model%20copy.dart';
import 'package:weather_assesment/app/module/weather/ui_model/weather_ui_model.dart';
import 'package:weather_assesment/app/utils/location/location_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _weatherRepository =
      serviceLocator<WeatherRepository>();

  String? cityName = 'Loading..!';

  WeatherUIModel? weatherData;

  checklocation() async {
    // Add the BuildContext parameter here
    Position? currentPosition =
        await LocationService.getLocationWithPermissionCheck();
    if (currentPosition != null) {
      setCurrentLocation(currentPosition.latitude, currentPosition.longitude);
    } else {
      // Handle the case when the location couldn't be obtained
    }
  }

  getWeather() async {
    await checklocation();

    if (getLat != null) {
      var queryParams =
          WeatherParams(lat: getLat.toString(), lon: getLon.toString());
      //  cityName = await LocationSer.getCityName(getLat, getLon);

      WeatherResponseModel response =
          await _weatherRepository.getSevenDaysWeather(queryParams);

      WeatherUIModel weatherUIModel =
          WeatherUIModel.fromWeatherResponse(response);

      weatherData = weatherUIModel;
      cityName = weatherData?.timezone;
      notifyListeners();
    } else {
      await checklocation();
      getWeather();
    }
  }

  //   "${ImageValues.weather_image_url}${data.current!.weather?[0].icon}@2x.png"),

  WeatherUIModel convertToUIModel(WeatherResponseModel response) {
    String? iconPrefix = ImageValues.weather_image_url;
    final currentWeatherIcon = response.current?.weather?[0].icon;

    String? currentWeatherUrl = "$iconPrefix$currentWeatherIcon@2x.png";

    return WeatherUIModel(
      latitude: response.lat,
      longitude: response.lon,
      timezone: response.timezone,
      timezoneOffset: response.timezoneOffset,
      currentTemperature: '${response.current!.temp.round()}°',
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

  var _currentLat;
  var _currentLon;

  void setCurrentLocation(Lat, Lon) {
    _currentLat = Lat;
    _currentLon = Lon;
  }

  get getLat => _currentLat;
  get getLon => _currentLon;
}
