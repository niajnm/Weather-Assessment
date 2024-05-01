import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_assesment/app/base_app/base_app.dart';
import 'package:weather_assesment/app/core/provider/provider.dart';
import 'package:weather_assesment/app/core/services/service_locator.dart';
import 'package:weather_assesment/app/utils/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';

void main() async {
  EnvConfig devConfig = EnvConfig(
    appName: "Flutter Dev",
    baseUrl: "https://api.openweathermap.org/",
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  WidgetsFlutterBinding.ensureInitialized();
  // After adding any variable in .env then enable this line
  //await dotenv.load(fileName: "conf/.env");

  await GetStorage.init(databaseName);
  await Hive.initFlutter();

  await Hive.openBox<String>('json_data');

  await ScreenUtil.ensureScreenSize();
  await ServiceLocator.setUpServiceLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MultiProvider(providers: ProviderPath.providersList, child: BaseApp()));
}
