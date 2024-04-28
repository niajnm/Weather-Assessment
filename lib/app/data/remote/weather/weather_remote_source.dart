import 'package:flutter_craft/app/data/remote/weather/model/weather_params.dart';
import 'package:flutter_craft/app/data/remote/weather/model/weather_response_model.dart';

abstract class WeatherRemoteSource {
  Future<WeatherResponseModel> getSevenDaysWeather(WeatherParams queryParams);
}
