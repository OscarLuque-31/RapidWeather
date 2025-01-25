import 'package:rapid_weather/models/weather_hour.dart';

class Weather {
  final double temperatura; // Temperatura actual
  final double velocidadViento; // Velocidad del viento
  final double visibilidad; // Visibilidad
  final double uv; // Índice UV
  final double temperaturaMinima; // Temperatura mínima del día
  final double temperaturaMaxima; // Temperatura máxima del día
  final String estadoClima; // Estado del clima
  final List<WeatherHour> horas; // Lista de WeatherHour (pronóstico por horas)

  Weather({
    required this.temperatura,
    required this.velocidadViento,
    required this.visibilidad,
    required this.uv,
    required this.temperaturaMinima,
    required this.temperaturaMaxima,
    required this.estadoClima,
    required this.horas,
  });

  // Método para crear una instancia de Weather a partir de un JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
  var current = json['current'] ?? {}; // Datos actuales
  var forecast = json['forecast']?['forecastday']?[0] ?? {}; // Pronóstico del primer día

  // Parsear las horas del día
  List<WeatherHour> horas = (forecast['hour'] as List?)?.map((hourJson) {
    return WeatherHour.fromJson(hourJson); // Crear WeatherHour por cada hora
  }).toList() ?? [];

  // Obtener el estado del clima de current si no está disponible en forecast
  String estadoClima = forecast['condition']?['text'] ??
                       current['condition']?['text'] ??
                       'Desconocido'; // Si no se encuentra, será 'Desconocido'

  // Crear e inicializar Weather
  return Weather(
    temperatura: current['temp_c']?.toDouble() ?? 0.0,
    velocidadViento: current['wind_kph']?.toDouble() ?? 0.0,
    visibilidad: current['vis_km']?.toDouble() ?? 0.0,
    uv: current['uv']?.toDouble() ?? 0.0,
    temperaturaMinima: forecast['mintemp_c']?.toDouble() ?? 0.0,
    temperaturaMaxima: forecast['maxtemp_c']?.toDouble() ?? 0.0,
    estadoClima: estadoClima, // Usar el estado del clima extraído
    horas: horas, // Lista de WeatherHour
  );
}

}
