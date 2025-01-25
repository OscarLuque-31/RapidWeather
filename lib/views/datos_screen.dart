import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/widgets/custom_date_picker_text_field.dart';
import 'package:rapid_weather/widgets/custom_text_field.dart';

class DatosScreen extends StatelessWidget {
  const DatosScreen({super.key});

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

          const Text(
            "Información requerida",
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w700,
              fontSize: 25,
              color: AppColors.azulClaroWeather,
            ),
          ),
          // Contenedor inferior con bordes redondeados
          Container(
            margin: const EdgeInsets.all(16.0),
            width: 360,
            height: 385,
            decoration: BoxDecoration(
              color: AppColors.azulGrisaceoWeather, // Fondo azul oscuro
              borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextField(width: 315, height: 62, hintText: "Nombre de usuario"),
                const SizedBox(height: 10.0),
                const CustomTextField(width: 315, height: 62, hintText: "Nombre"),
                const SizedBox(height: 10.0),
                const CustomTextField(width: 315, height: 62, hintText: "Apellidos"),
                const SizedBox(height: 10.0),
                const CustomDatePickerTextField(width: 315, height: 62, hintText: "Fecha de nacimiento"),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.principal);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.azulOscuroWeather, 
                    minimumSize: const Size(315, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text(
                    "Empezar",
                    style: TextStyle(
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.blancoWeather,
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
