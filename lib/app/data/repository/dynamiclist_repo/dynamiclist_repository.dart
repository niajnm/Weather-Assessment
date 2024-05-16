import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';

abstract class DynamicListRepository {
  Future<WeatherResponseModel> getSevenDaysWeather(WeatherParams queryParams);
    Future<dynamic> getDynamicList();
    Future<dynamic> getDynamicListWithParam(WeatherParams queryParams);
  Future<dynamic> getSingleInfo(id);
}
