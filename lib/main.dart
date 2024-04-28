import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_craft/app/base_app/base_app.dart';
import 'package:flutter_craft/app/core/provider/provider.dart';
import 'package:flutter_craft/app/utils/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'app/core/services/firebase_service.dart';
import 'app/core/services/service_locator.dart';
import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';

void main() async {
  // EnvConfig devConfig = EnvConfig(
  //   appName: "Flutter Prod",
  //   baseUrl: "https://api.onefish.app/",
  //   shouldCollectCrashLog: true,
  // );

  // BuildConfig.instantiate(
  //   envType: Environment.DEVELOPMENT,
  //   envConfig: devConfig,
  // );

  // WidgetsFlutterBinding.ensureInitialized();

  // await dotenv.load(fileName: "conf/.env");

  // await GetStorage.init(databaseName);

  // Enable it after adding firebase connection to this project
  // await FirebaseService.enableFirebase(Environment.DEVELOPMENT);

  await ScreenUtil.ensureScreenSize();
  // await ServiceLocator.setUpServiceLocator();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(
      providers: ProviderPath.providersList, child: BaseApp()));
}
