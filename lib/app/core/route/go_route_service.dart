import 'package:flutter/material.dart';
import 'package:flutter_craft/app/core/route/route_paths.dart';
import 'package:flutter_craft/app/module/home_page.dart';
import 'package:flutter_craft/app/module/weather/view/weather_main_screen.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
class GoRouterService {
  bool userIsNotLoggedIn = false;

  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // GoRoute(
      //   path: RoutePaths.mainPage,
      //   builder: (context, state) => HomePage(),
      // ),
      GoRoute(
        path: RoutePaths.weatherMainPage,
        builder: (context, state) => const WeatherMainScreen(),
      ),

      // GoRoute(
      //   path: RoutePaths.homePage,
      //   builder: (context, state) => HomePage(),
      //   // redirect: (context, state) {
      //   //   final routerService = RouterService();
      //   //   if (routerService.userIsNotLoggedIn) {
      //   //     return "/login";
      //   //   }
      //   //   return "/";
      //   // },
      // ),
      // GoRoute(
      //   path: RoutePaths.settingPage,
      //   builder: (context, state) => SettingPage(),
      // ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Error Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go("/"),
          child: const Text("Go to home page"),
        ),
      ),
    );
  }
}
