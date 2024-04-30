import 'package:dio/dio.dart';
import 'package:weather_assesment/app/core/services/service_locator.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {
  // final UserInfoRepository _userRepository =
  //     serviceLocator<UserInfoRepository>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    var customHeaders = {'Accept': 'application/json'};
    // var token = await _userRepository.getUserToken();
    customHeaders.addAll({'Authorization': 'Bearer token'});
    return customHeaders;
  }
}
