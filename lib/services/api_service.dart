import 'dart:convert';
import 'package:http/http.dart' as http;
// Asegúrate de que esta importación sea correcta
import 'package:rapid_weather/models/location.dart'; // Asegúrate de que esta importación sea correcta
import 'package:rapid_weather/models/weather_response.dart'; // Asegúrate de que esta importación sea correcta

class ApiService {
  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = "b32cc93ddc9a442cac3181506252001";

  // Método para obtener el clima de un día
  Future<WeatherResponse> fetchWeatherForOneDay(String localizacion) async {
    final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$localizacion&days=1&aqi=no&alerts=no&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar la respuesta usando UTF-8
        final decodedResponse = utf8.decode(response.bodyBytes);

        // Convertir la cadena decodificada en un Map
        final Map<String, dynamic> data = json.decode(decodedResponse);

        // Pasar el Map decodificado a Weather.fromJson
        return WeatherResponse.fromJson(data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

   // Método para obtener el clima en el momento
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

      return WeatherResponse.fromJson(data);
    } else {
      throw Exception('Failed to load weather: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error fetching weather: $e');
  }
}


  // Método para buscar ubicaciones
  Future<List<Location>> fetchLocations(String ciudad) async {
    final url = Uri.parse('$baseUrl/search.json?key=$apiKey&q=$ciudad&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar la respuesta usando UTF-8
        final decodedResponse = utf8.decode(response.bodyBytes);

        // Convertir la cadena decodificada en una lista dinámica
        final List<dynamic> data = json.decode(decodedResponse);

        // Convertir la lista dinámica en una lista de instancias de Location
        return Location.listFromJson(data);
      } else {
        throw Exception('Failed to load locations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching locations: $e');
    }
  }

  // Método para obtener el pronóstico del tiempo para 3 días
  Future<WeatherResponse> fetchWeatherForThreeDays(String localizacion) async {
    final url = Uri.parse(
        '$baseUrl/forecast.json?key=$apiKey&q=$localizacion&days=3&aqi=yes&alerts=yes&lang=es');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodificar la respuesta usando UTF-8
        final decodedResponse = utf8.decode(response.bodyBytes);

        // Convertir la cadena decodificada en un Map
        final Map<String, dynamic> data = json.decode(decodedResponse);

        // Pasar el Map decodificado a ForeCast.fromJson
        return WeatherResponse.fromJson(data);
      } else {
        throw Exception('Failed to load forecast: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching forecast: $e');
    }
  }
}
