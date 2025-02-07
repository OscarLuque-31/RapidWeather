import 'package:flutter/material.dart';
import 'package:rapid_weather/models/day.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class EspecificacionesClimaDia extends StatelessWidget {
  final Day day;

  const EspecificacionesClimaDia({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Clima medio del día",
          style: TextStyle(
            fontFamily: 'ReadexPro',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.azulClaroWeather, 
          ),
        ),
        const SizedBox(height: 10), 
        Container(
          height: 200,
          width: 350,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.azulGrisaceoWeather,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildItem(Icons.thermostat, '${day.maxtempC.round()}°C', 'Máx'),
                    const SizedBox(height: 20),
                    _buildItem(Icons.ac_unit, '${day.mintempC.round()}°C', 'Mín'),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildItem(Icons.air, '${day.maxwindKph.round()} km/h', 'Viento'),
                    const SizedBox(height: 20),
                    _buildItem(Icons.water_drop, '${day.avghumidity}%', 'Humedad'),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildItem(Icons.umbrella, '${day.dailyChanceOfRain}%', 'Lluvia'),
                    const SizedBox(height: 20),
                    _buildItem(Icons.wb_sunny, '${day.uv}', 'UV'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Método para construir cada ítem de información
  Widget _buildItem(IconData icon, String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(icon, color: AppColors.blancoWeather, size: 28.0),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            color: AppColors.blancoWeather,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
