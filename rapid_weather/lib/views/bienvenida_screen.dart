import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/services/bbdd_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';

/// Pantalla de bienvenida que verifica si el usuario está registrado y 
/// lo redirige a la pantalla principal o le permite registrarse.
class BienvenidaScreen extends StatefulWidget {
  const BienvenidaScreen({super.key});

  @override
  State<BienvenidaScreen> createState() => _BienvenidaScreenState();
}

class _BienvenidaScreenState extends State<BienvenidaScreen> {
  bool isRegistered = false; // Estado para almacenar si el usuario está registrado

  @override
  void initState() {
    super.initState();
    _checkRegistrationStatus(); // Verifica el estado de registro al iniciar la pantalla
  }

  /// Verifica si el usuario ya está registrado en la base de datos.
  /// Si está registrado, lo redirige automáticamente a la pantalla principal.
  Future<void> _checkRegistrationStatus() async {
    bool isRegistered = await DBService().isUserRegistered();
    setState(() {
      this.isRegistered = isRegistered;
    });

    if (isRegistered) {
      if (mounted) {
        // Si está registrado, redirige directamente a la pantalla principal y limpia el historial de navegación
        Navigator.pushReplacementNamed(context, AppRoutes.principal);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Logo centrado en la pantalla
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/logo_rapid_weather.png',
                width: 300,
              ),
            ),
          ),

          // Contenedor inferior con mensaje y botón de inicio
          Container(
            margin: const EdgeInsets.only(bottom: 16.0), 
            width: 360,
            height: 180,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppColors.azulGrisaceoWeather, 
              borderRadius: BorderRadius.circular(16.0), 
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Mensaje de bienvenida
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

                // Botón de "Empezar"
                ElevatedButton(
                  onPressed: () {
                    if (!isRegistered) {
                      // Si no está registrado, lo lleva a la pantalla de datos
                      Navigator.pushNamed(context, AppRoutes.datos);
                    } else {
                      // Si ya está registrado, lo redirige a la pantalla principal
                      Navigator.pushReplacementNamed(context, AppRoutes.principal);
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
