import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';

abstract class DynamicListRemoteSource {
  Future<dynamic> getSevenDaysWeather(WeatherParams queryParams);

  Future<dynamic> getDynamicList();
  Future<dynamic> getDynamicListWithParam(WeatherParams queryParams);
  Future<dynamic> getSingleInfo(id);
}
