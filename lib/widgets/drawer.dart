import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class WidgetDrawer extends StatelessWidget {
  const WidgetDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.azulOscuroWeather,
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 70),
              color: AppColors.azulOscuroWeather,
              child: Center(
                child: Image.asset(
                  'assets/images/logo_rapid_weather.png',
                  width: 200,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 30),
              leading:
                  const Icon(Icons.search, color: AppColors.azulClaroWeather),
              title: const Text(
                'Buscar Ciudad',
                style: TextStyle(
                  color: AppColors.azulClaroWeather,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w300,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.buscarCiudad);
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 30),
              leading:
                  const Icon(Icons.cloud, color: AppColors.azulClaroWeather),
              title: const Text(
                'Condiciones del Clima',
                style: TextStyle(
                  color: AppColors.azulClaroWeather,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w300,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.condicionesClima);
              },
            ),
            const Spacer(),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 30),
              leading: const Icon(Icons.info_outline,
                  color: AppColors.azulClaroWeather),
              title: const Text(
                'Atribuciones',
                style: TextStyle(
                  color: AppColors.azulClaroWeather,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w300,
                ),
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.atribuciones);
              },
            ),
          ],
        ),
      ),
    );
  }
}
