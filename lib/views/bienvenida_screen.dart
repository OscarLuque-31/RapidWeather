import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Espacio para centrar el logo en la pantalla
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/logo_rapid_weather.png',
                width: 300,
              ),
            ),
          ),

          // Contenedor inferior con bordes redondeados
          Container(
            margin: const EdgeInsets.only(bottom: 16.0), // Margen inferior
            width: 360,
            height: 180,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.azulGrisaceoWeather, // Fondo azul oscuro
              borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Conecta con tu clima, sin complicaciones",
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w700,
                    color: AppColors.azulClaroWeather,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.datos);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blancoWeather, // Color del botón
                    minimumSize: const Size(320, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    "Empezar",
                    style: TextStyle(
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.azulGrisaceoWeather,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
