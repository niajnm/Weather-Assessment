import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_assesment/app/data/remote/end_point_api.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/weather_remote_source.dart';

import '../../../core/base/base_remote_source.dart';

class WeatherRemoteSourceImpl extends BaseRemoteSource
    implements WeatherRemoteSource {
  @override
  Future<WeatherResponseModel> getSevenDaysWeather(WeatherParams queryParams) {
    log('post data $queryParams');

    var endpoint = weatherBaseUrl;
    var dioCall = dioCli.get(endpoint, queryParameters: queryParams.toJson());

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseSevenDaysWeatherResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  WeatherResponseModel _parseSevenDaysWeatherResponse(
      Response<dynamic> response) {
    log(' Weather response  $response');
    var result = WeatherResponseModel.fromJson(response.data);
    return result;
  }
}
