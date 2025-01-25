import 'package:rapid_weather/models/weather.dart';

class ForeCast {
  final List<Weather> pronostico; // Lista de Weather (para cada día del pronóstico)

  ForeCast({required this.pronostico});

  // Método para crear una instancia de ForeCast a partir de un JSON
  factory ForeCast.fromJson(Map<String, dynamic> json) {
    var forecastDays = json['forecast']?['forecastday'] as List? ?? [];
    List<Weather> pronostico = forecastDays.map((forecastJson) {
      return Weather.fromJson(forecastJson); // Crear Weather por cada día
    }).toList();

    return ForeCast(pronostico: pronostico); // Devolver ForeCast
  }
}
