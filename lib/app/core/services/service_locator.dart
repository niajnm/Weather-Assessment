import 'package:weather_assesment/app/data/local/preference/preference_manager.dart';
import 'package:weather_assesment/app/data/local/preference/preference_manager_impl.dart';
import 'package:weather_assesment/app/data/remote/remote_dynamiclist/dynamiclist_remote_source.dart';
import 'package:weather_assesment/app/data/remote/remote_dynamiclist/dynamiclist_remote_source_impl.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/weather_remote_source.dart';
import 'package:weather_assesment/app/data/remote/weather_remote/weather_remote_source_impl.dart';
import 'package:weather_assesment/app/data/repository/dynamiclist_repo/dynamiclist_repository.dart';
import 'package:weather_assesment/app/data/repository/dynamiclist_repo/dynamiclist_repository_impl.dart';
import 'package:weather_assesment/app/data/repository/weather_repository/weather_repository.dart';
import 'package:weather_assesment/app/data/repository/weather_repository/weather_repository_impl.dart';
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

    // Register the WeatherRemoteDataSource in the data module
    serviceLocator.registerLazySingleton<DynamicListRemoteSource>(
        () => DynamicRemoteSourceImpl());
    // Register the WeatherRemoteDataSource in the data module
    serviceLocator.registerLazySingleton<DynamicListRepository>(
        () => DynamicListRepositoryImpl());
  }
}
