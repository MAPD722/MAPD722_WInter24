import 'package:flutter/material.dart';
import 'package:weather_app/LocationScreen.dart';
import 'package:weather_app/search_city_screen.dart';
import 'package:weather_app/weather_screen.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const LocationScreen(),
        '/search': (context) => const SearchForCityScreen(),
        '/weather': (context) => const WeatherScreen(),
      },
    );
  }
}
