import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_craft/app/core/values/app_values.dart';

import 'package:flutter_craft/app/core/values/text_style.dart';
import 'package:flutter_craft/app/module/weather/controller/WeatherViewModel.dart';
import 'package:flutter_craft/app/module/weather/widget/capsule_widget.dart';
import 'package:flutter_craft/app/module/weather/widget/froster_glass.dart';
import 'package:provider/provider.dart';

class WeatherMainScreen extends StatefulWidget {
  const WeatherMainScreen({super.key});

  @override
  State<WeatherMainScreen> createState() => _WeatherMainScreenState();
}

class _WeatherMainScreenState extends State<WeatherMainScreen> {
  _getSevenDaysWeatherList() async {
    // double currentLat =
    //     Provider.of<HomeViewModel>(context, listen: false).getLat();
    // double currentLon =
    //     Provider.of<HomeViewModel>(context, listen: false).getLon();

    log('waether page opren');

    await Provider.of<WeatherViewModel>(context, listen: false).getWeather();
  }

  @override
  Widget build(BuildContext context) {
    _getSevenDaysWeatherList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Page'),
      ),
      backgroundColor: Color.fromARGB(255, 115, 164, 228),
      body: Stack(
        children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(60),
              border: Border.all(color: Colors.white.withOpacity(0.13)),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    //  background: linear-gradient(135deg, #97ABFF 0%, #123597 100%);

                    //begin color
                    Color(0xFF97ABFF),
                    Color.fromARGB(202, 30, 49, 99)
                    //end color
                    // Colors.white.withOpacity(0.01),
                  ]),
            ),
          )),
          Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 40, 0, 15),
                  child: Text(
                    'Dhaka',
                    style: displayLargeTextStyle,
                    //style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.gps_fixed),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Current Location'),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud,
                          size: 120,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 28.0),
                          child: Text(
                            '30"',
                            style: headlineLargeTextStyle,
                          ),
                        )
                      ],
                    ),
                    Text(
                      'Party cloud',
                      style: bodyLargeTextStyleDark,
                    ),
                    CapsuleWidget(day: 'Today', icon: '', temp: '30'),
                  ],
                )
              ]),
        ],
      ),
    );
  }
}
