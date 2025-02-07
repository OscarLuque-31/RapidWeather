import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class AtribucionesScreen extends StatelessWidget {
  const AtribucionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.azulClaroWeather,
                size: 25,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.principal);
              },
            ),
            const Spacer(),
            Image.asset(
              'assets/images/small_logo.png',
              width: 40,
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          const Text(
            'Atribuciones',
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.azulClaroWeather,
            ),
          ),
          const SizedBox(height: 10),

          _buildAttribution(
            'API de Clima',
            'Datos del clima proporcionados por la API de WeatherApi',
          ),
          _buildAttribution(
            'Imágenes',
            'Las imágenes de clima son cortesía de Freepik y otros colaboradores.',
          ),
          _buildAttribution(
            'Fuentes',
            'La fuente utilizada en esta aplicación es la fuente "Readex Pro" de Google Fonts.',
          ),

          const SizedBox(height: 10),

          const Text(
            'Créditos',
            style: TextStyle(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: AppColors.azulClaroWeather,
            ),
          ),
          const SizedBox(height: 10),

          _buildCredit(
            'Desarrollado por:',
            'Óscar Luque Hidalgo',
          ),
          _buildCredit(
            'Diseño:',
            'Diseño visual por Óscar Luque Hidalgo',
          ),
        ],
      ),
    );
  }

  // Método para crear un widget de Atribución
  Widget _buildAttribution(String title, String description) {
    return Card(
      color: AppColors.azulGrisaceoWeather, 
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColors.azulClaroWeather,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.blancoWeather,
          ),
        ),
      ),
    );
  }

  // Método para crear un widget de Crédito
  Widget _buildCredit(String title, String description) {
    return Card(
      color: AppColors.azulGrisaceoWeather, 
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: AppColors.azulClaroWeather,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.blancoWeather,
          ),
        ),
      ),
    );
  }
}
