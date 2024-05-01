import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:weather_assesment/app/core/services/service_locator.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/weather_remote_source.dart';
import 'package:weather_assesment/app/utils/internet_connection.dart';
import 'weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteSource _remoteSource =
      serviceLocator<WeatherRemoteSource>();

  @override
  Future<WeatherResponseModel> getSevenDaysWeather(
      WeatherParams queryParams) async {
    // var box = await Hive.openBox<WeatherResponseModel>('weather_box');

    bool isConnected = await InternetConnect.isInternetConnected();
    if (isConnected) {
      var apiRresponse = await _remoteSource.getSevenDaysWeather(queryParams);

      print('Device is connected to the internet.');

      return _parseSevenDaysWeatherResponse(apiRresponse);
    } else {
      print('Device is not connected to the internet.');

      return _parseSevenDaysWeatherResponseFromHive();
    }
  }

  Future<WeatherResponseModel> _parseSevenDaysWeatherResponseFromHive() async {
    // Open the Hive box
    var box = await Hive.openBox<String>('json_data');

    // Retrieve JSON data from the box
    String? storedJsonData = box.get('data');
    print('Stored JSON Data: $storedJsonData');

    // Close the box when done with it
    //await box.close();

    // Check if JSON data is available
    if (storedJsonData != null) {
      // Parse the JSON data into a WeatherResponseModel object

      log('Stored JSON Datafrom hive : $storedJsonData');

      return WeatherResponseModel.fromJson(json.decode(storedJsonData));
    } else {
      // Handle the case where no JSON data is stored
      return WeatherResponseModel.fromJson(json.decode(storedJsonData!));
    }
  }

  Future<WeatherResponseModel> _parseSevenDaysWeatherResponse(
      Response<dynamic> response) async {
    var box = await Hive.openBox<String>('json_data');
    // Clear all data stored in the box
    await box.clear();
    // Save JSON data to the box
    String jsonData = "$response";
    // await box.put('data', jsonData);
    await box.put('data', jsonData);

    log(' Weather response  $response');
    var result = WeatherResponseModel.fromJson(response.data);
    return result;
  }
}
