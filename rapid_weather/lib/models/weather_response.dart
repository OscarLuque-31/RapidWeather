import 'package:rapid_weather/models/forecast.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/models/weather_current.dart';

/// Clase WeatherResponse que representa todos los datos,
/// es la clase donde se guarda toda la información,
/// desde ella podemos acceder a cualquier instancia del clima
/// Ejemplo: weatherResponse.location.name
class WeatherResponse {
  final Location location;
  final Current current;
  final Forecast? forecast;

  WeatherResponse({
    required this.location,
    required this.current,
    this.forecast,
  });

  // Método para transformar el JSON a un objeto WeatherResponse y lo retorna
  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: Location.fromJson(json['location'] ?? {}),
      current: Current.fromJson(json['current'] ?? {}),
      forecast: Forecast.fromJson(json['forecast'] ?? {}),
    );
  }

}
