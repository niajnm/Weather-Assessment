import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:weather_assesment/app/data/remote/end_point_api.dart';
import 'package:weather_assesment/app/data/remote/remote_dynamiclist/dynamiclist_remote_source.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
import '../../../core/base/base_remote_source.dart';

class DynamicRemoteSourceImpl extends BaseRemoteSource
    implements DynamicListRemoteSource {
  @override
  Future<dynamic> getSevenDaysWeather(WeatherParams queryParams) {
    log('post data $queryParams');

    var endpoint = weatherBaseUrl;
    var dioCall = dioCli.get(endpoint, queryParameters: queryParams.toJson());

    try {
      return callApiWithErrorParser(dioCall).then((response) => response);
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<dynamic> getDynamicList( ) {
   //var endpoint = "product/order/user/wise/list";
    var endpoint = weatherBaseUrl;
    var dioCall = dioCli.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseOrderStatusResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  WeatherResponseModel _parseOrderStatusResponse(Response<dynamic> response) {
    return WeatherResponseModel.fromJson(response.data);
  }

  
  @override
  Future getSingleInfo(id) {
    // TODO: implement getSingleInfo
    throw UnimplementedError();
  }
  
  @override
  Future getDynamicListWithParam(WeatherParams queryParams) {
    // TODO: implement getDynamicListWithParam
    throw UnimplementedError();
  }
}
