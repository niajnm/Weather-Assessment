import 'package:weather_assesment/app/core/services/service_locator.dart';
import 'package:weather_assesment/app/data/remote/remote_dynamiclist/dynamiclist_remote_source.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
import 'dynamiclist_repository.dart';

class DynamicListRepositoryImpl implements DynamicListRepository {
  final DynamicListRemoteSource _remoteSource =
      serviceLocator<DynamicListRemoteSource>();

  @override
  Future<dynamic> getDynamicListWithParam(WeatherParams queryParams) {
    return _remoteSource.getDynamicList();
  }

  @override
  Future<dynamic> getDynamicList() {
    return _remoteSource.getDynamicList();
  }

  @override
  Future<WeatherResponseModel> getSevenDaysWeather(WeatherParams queryParams) {
    // TODO: implement getSevenDaysWeather
    throw UnimplementedError();
  }

  @override
  Future getSingleInfo(id) {
    // TODO: implement getSingleInfo
    throw UnimplementedError();
  }
}
