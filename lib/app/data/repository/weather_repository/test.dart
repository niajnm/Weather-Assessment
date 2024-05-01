// import 'package:hive/hive.dart';
// import 'package:weather_assesment/app/core/services/service_locator.dart';
// import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
// import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
// import 'package:weather_assesment/app/data/remote/weather_remote/weather_remote_source.dart';
// import 'package:weather_assesment/app/utils/internet_connection.dart';

// import 'weather_repository.dart';

// class WeatherRepositoryImpl implements WeatherRepository {
//   final WeatherRemoteSource _remoteSource =
//       serviceLocator<WeatherRemoteSource>();

//   @override
//   Future<WeatherResponseModel> getSevenDaysWeather(
//       WeatherParams queryParams) async {
//     var box = await Hive.openBox<WeatherResponseModel>('weather_box');

//     // bool isConnected = await InternetConnect.isInternetConnected();
//     // if (isConnected) {
//     //   var apiRresponse = await _remoteSource.getSevenDaysWeather(queryParams);
//     //   await box.put('weather_data', apiRresponse);

//     //   print('Device is connected to the internet.');

//     //   return apiRresponse;
//     // } else {
//     //   var box = await Hive.openBox<WeatherResponseModel>('weather_box');
//     //   WeatherResponseModel? retrievedData = box.get('weather_data');

//     //   print('Device is not connected to the internet.');

//     //   return retrievedData!;
//     // }


//      var apiRresponse = await _remoteSource.getSevenDaysWeather(queryParams);
//       await box.put('weather_data', apiRresponse);
//         // var box = await Hive.openBox<WeatherResponseModel>('weather_box');
//       WeatherResponseModel? retrievedData = box.get('weather_data');

//       print('Device is not connected to the internet.');

//         return retrievedData!;
//   }

//   Future<WeatherResponseModel> getWeather(WeatherParams queryParams) {
//     return _remoteSource.getSevenDaysWeather(queryParams);
//   }
// }