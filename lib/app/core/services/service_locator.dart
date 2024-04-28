import 'package:flutter_craft/app/data/local/preference/preference_manager.dart';
import 'package:flutter_craft/app/data/local/preference/preference_manager_impl.dart';
import 'package:flutter_craft/app/data/remote/weather/weather_remote_source.dart';
import 'package:flutter_craft/app/data/remote/weather/weather_remote_source_impl.dart';
import 'package:flutter_craft/app/data/repository/weather/weather_repository.dart';
import 'package:flutter_craft/app/data/repository/weather/weather_repository_impl.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  static Future<void> setUpServiceLocator() async {
    serviceLocator.registerLazySingleton<PreferenceManager>(
        () => PreferenceManagerImpl());

    // Register the WeatherRemoteDataSource in the data module
    serviceLocator.registerLazySingleton<WeatherRemoteSource>(
        () => WeatherRemoteSourceImpl());

    serviceLocator.registerLazySingleton<WeatherRepository>(
        () => WeatherRepositoryImpl());

    // serviceLocator.registerLazySingleton<ConfigLocalSource>(
    //     () => ConfigLocalSourceImpl());

    // serviceLocator
    //     .registerLazySingleton<ConfigRepository>(() => ConfigRepositoryImpl());

    // serviceLocator
    //     .registerLazySingleton<HomeRemoteSource>(() => HomeRemoteSourceImpl());

    // serviceLocator
    //     .registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  }
}
