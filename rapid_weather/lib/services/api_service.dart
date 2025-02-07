import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/models/weather_response.dart';

class ApiService {
  // URL base de la API del clima
  final String baseUrl = "https://api.weatherapi.com/v1";

  // Clave de API para autenticar las solicitudes (debería almacenarse de forma segura)
  final String apiKey = "b32cc93ddc9a442cac3181506252001";

  /// Método para obtener el clima de un día en una ubicación específica
  ///
  /// Parámetros:
  /// - [localizacion]: Nombre de la ciudad o coordenadas (latitud,longitud)
  ///
  /// Retorna un objeto `WeatherResponse` con la información climática del día
  Future<WeatherResponse> fetchWeatherForOneDay(String localizacion) async {
    final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$localizacion&days=1&aqi=no&alerts=no&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = json.decode(decodedResponse);

        // Convertir la respuesta JSON en un objeto `WeatherResponse`
        WeatherResponse weatherResponse = WeatherResponse.fromJson(data);

        return weatherResponse;
      } else {
        // Lanza una excepción si la solicitud falla
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  /// Método para obtener el clima actual en una ubicación específica
  ///
  /// Parámetros:
  /// - [localizacion]: Nombre de la ciudad o coordenadas (latitud,longitud)
  ///
  /// Retorna un objeto `WeatherResponse` con la información climática actual
  Future<WeatherResponse> fetchWeatherCurrent(String localizacion) async {
    final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$localizacion&days=1&aqi=yes&alerts=yes&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = json.decode(decodedResponse);

        // Verificar si la respuesta contiene un error
        if (data.containsKey('error')) {
          throw Exception(data['error']['message'] ?? 'Error desconocido');
        }

        // Convertir la respuesta JSON en un objeto `WeatherResponse`
        WeatherResponse weatherResponse = WeatherResponse.fromJson(data);

        return weatherResponse;
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  /// Método para buscar ubicaciones según un nombre de ciudad
  ///
  /// Parámetros:
  /// - [ciudad]: Nombre parcial o completo de la ciudad a buscar
  ///
  /// Retorna una lista de objetos `Location` con coincidencias
  Future<List<Location>> fetchLocations(String ciudad) async {
    final url = Uri.parse('$baseUrl/search.json?key=$apiKey&q=$ciudad&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final List<dynamic> data = json.decode(decodedResponse);

        // Convertir la lista de ubicaciones JSON en una lista de objetos `Location`
        return Location.listFromJson(data);
      } else {
        throw Exception('Failed to load locations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching locations: $e');
    }
  }

  /// Método para obtener el pronóstico del clima para los próximos 3 días
  ///
  /// Parámetros:
  /// - [localizacion]: Nombre de la ciudad o coordenadas (latitud,longitud)
  ///
  /// Retorna un objeto `WeatherResponse` con el pronóstico extendido de 3 días
  Future<WeatherResponse> fetchWeatherForThreeDays(String localizacion) async {
    final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$localizacion&days=3&aqi=yes&alerts=yes&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> data = json.decode(decodedResponse);

        // Convertir la respuesta JSON en un objeto `WeatherResponse`
        WeatherResponse weatherResponse = WeatherResponse.fromJson(data);

        return weatherResponse;
      } else {
        throw Exception('Failed to load forecast: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching forecast: $e');
    }
  }
}
