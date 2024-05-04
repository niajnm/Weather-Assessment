import 'package:dio/dio.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_assesment/app/data/remote/end_point_api.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_params.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/model/weather_response_model.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/weather_remote_source_impl.dart';
import 'package:weather_assesment/app/utils/constants.dart';
import 'package:weather_assesment/flavors/build_config.dart';
import 'package:weather_assesment/flavors/env_config.dart';
import 'package:weather_assesment/flavors/environment.dart';
import 'remote_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  WeatherRemoteSourceImpl remoteDataSource = WeatherRemoteSourceImpl();
  final MockDio mockDio = MockDio();

  group('fetchRepositoryList', () {
    final params = WeatherParams(lat: '23.716103', lon: '90.4751949');

    test(
        'returns a WeatherResponseModel if the http call completes successfully',
        () async {
      final responseData = {
        "lat": 23.7161,
        "lon": 90.4752,
        "timezone": "Asia/Dhaka",
        "current": {
          "dt": 1714865027,
          "temp": 25.03,
          // Add other fields here
        },
        "daily": [
          {
            "dt": 1714885200,
            "temp": {
              "day": 36.08,
              // Add other fields here
            },
            // Add other fields here
          },
          // Add other daily data here
        ]
      };

      // Mock the Dio client's response
      when(mockDio.get(
        weatherBaseUrl,
        queryParameters: anyNamed('queryParameters'),
      )).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: weatherBaseUrl)));

      // Call the method under test
      final result = await remoteDataSource.getSevenDaysWeather(params);

      // Verify result
      expect(result, isA<WeatherResponseModel>());
      // Add more assertions here to verify the structure and data of the response
    });
  });
}

void setupBuildConfigForTesting() {
  // Initialize BuildConfig with test configurations
  EnvConfig testConfig = EnvConfig(
    appName: "Your Test App",
    baseUrl: "https://api.openweathermap.org/",
    shouldCollectCrashLog: false,
  );

  Logger(
    printer: PrettyPrinter(
        methodCount: loggerMethodCount,
        // number of method calls to be displayed
        errorMethodCount: loggerErrorMethodCount,
        // number of method calls if stacktrace is provided
        lineLength: loggerLineLength,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: testConfig,
  );
}
