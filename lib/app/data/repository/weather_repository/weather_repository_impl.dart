
import 'package:weather_assesment/app/core/services/service_locator.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/weather_remote_source.dart';

import 'weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRemoteSource _remoteSource = serviceLocator<WeatherRemoteSource>();

  @override
  Future<WeatherResponseModel> getSevenDaysWeather(WeatherParams queryParams) {
    return _remoteSource.getSevenDaysWeather(queryParams);
  }
}
