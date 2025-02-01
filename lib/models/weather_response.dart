import 'package:rapid_weather/models/forecast.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/models/weather_current.dart';

class WeatherResponse {
  final Location location;
  final Current current;
  final Forecast? forecast; // Ahora forecast es opcional

  WeatherResponse({
    required this.location,
    required this.current,
    this.forecast, // Forecast es opcional
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      location: Location.fromJson(json['location'] ?? {}),
      current: Current.fromJson(json['current'] ?? {}),
      forecast: Forecast.fromJson(json['forecast'] ?? {}),
    );
  }
}
