import 'package:flutter_craft/app/core/services/service_locator.dart';
import 'package:flutter_craft/app/data/remote/weather/model/weather_params.dart';
import 'package:flutter_craft/app/data/remote/weather/model/weather_response_model.dart';
import 'package:flutter_craft/app/data/remote/weather/weather_remote_source.dart';

import 'weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRemoteSource _remoteSource = serviceLocator<WeatherRemoteSource>();

  @override
  Future<WeatherResponseModel> getSevenDaysWeather(WeatherParams queryParams) {
    return _remoteSource.getSevenDaysWeather(queryParams);
  }
}
