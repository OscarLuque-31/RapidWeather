import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/services/bbdd_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class BienvenidaScreen extends StatefulWidget {
  const BienvenidaScreen({super.key});

  @override
  State<BienvenidaScreen> createState() => _BienvenidaScreenState();
}

class _BienvenidaScreenState extends State<BienvenidaScreen> {
  bool isRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus();
  }

  // Verificar si el usuario ya está registrado
  Future<void> _checkRegistrationStatus() async {
    bool isRegistered = await DBHelper().isUserRegistered();
    setState(() {
      this.isRegistered = isRegistered;
    });

    if (isRegistered) {
      if (mounted) {
        // Si está registrado, redirigimos directamente a la pantalla principal y limpiamos el stack
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.principal,  
          (Route<dynamic> route) => false, // Esto elimina todas las pantallas anteriores
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
            margin: const EdgeInsets.only(bottom: 16.0), 
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
                    if (!isRegistered) {
                      Navigator.pushNamed(context, AppRoutes.datos);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.principal,
                        (Route<dynamic> route) => false, // Elimina todas las rutas previas
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blancoWeather, 
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
