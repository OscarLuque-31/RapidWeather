import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/routes/routes.dart';

void main() async {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapid Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.azulOscuroWeather,
        scaffoldBackgroundColor: AppColors.azulOscuroWeather,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.azulOscuroWeather,
          foregroundColor: AppColors.blancoWeather,
        ),
      ),
      initialRoute: AppRoutes.bienvenida,
      routes: AppRoutes.routes,
    );
  }
}
