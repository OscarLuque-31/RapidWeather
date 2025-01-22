import 'package:flutter/material.dart';
import 'routes/routes.dart'; 

void main() {
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
        primaryColor: const Color(0xFF090C37),
        scaffoldBackgroundColor: const Color(0xFF090C37),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF090C37),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: AppRoutes.bienvenida, 
      routes: AppRoutes.routes,
    );
  }
}
