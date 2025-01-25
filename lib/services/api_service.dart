import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rapid_weather/models/weather.dart';

class ApiService {
  final String baseUrl = "https://api.weatherapi.com/v1";

  final String apiKey = "b32cc93ddc9a442cac3181506252001";

  Future<Weather> fetchWeatherForOneDay(String ciudad) async {
    final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$ciudad&days=1&aqi=yes&alerts=yes&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar la respuesta usando UTF-8
        final decodedResponse = utf8.decode(response.bodyBytes);

        // Convertir la cadena decodificada en un Map
        final Map<String, dynamic> data = json.decode(decodedResponse);

        // Pasar el Map decodificado a Weather.fromJson
        return Weather.fromJson(data);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

  // Future<List<Weather>> fetchWeather(String location, int days) async {
  //   final url = Uri.parse(
  //       "$baseUrl/forecast.json?key=$apiKey&q=$location&days=$days&aqi=yes&alerts=yes&lang=es");

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonData = json.decode(response.body);

  //     // Obtener la lista de forecastday (7 días)
  //     List<dynamic> forecastDays = jsonData['forecast']['forecastday'];

  //     // Mapear cada día a un objeto Weather
  //     return forecastDays.map((dayJson) {
  //       List<dynamic> hourlyData = dayJson['hour']; // Lista de datos por hora
  //       return Weather.fromJson(dayJson['day'], hourlyData);
  //     }).toList();
  //   } else {
  //     throw Exception("Error al cargar los datos del clima: ${response.statusCode}");
  //   }
  // }

