import 'package:flutter/material.dart';
import 'package:rapid_weather/services/api_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/views/localizaciones_favoritas_screen.dart';
import 'package:rapid_weather/widgets/localizacion_widget.dart';
import 'package:rapid_weather/services/bbdd_service.dart';
import 'package:rapid_weather/models/weather_response.dart';

class LocalizacionesFavoritas extends StatefulWidget {
  const LocalizacionesFavoritas({super.key});

  @override
  State<LocalizacionesFavoritas> createState() => _LocalizacionesFavoritasState();
}

class _LocalizacionesFavoritasState extends State<LocalizacionesFavoritas> {
  List<Map<String, dynamic>> _favoriteCities = [];
  final Map<String, WeatherResponse> _weatherData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Método que carga las localizaciones favoritas desde base de datos
  Future<void> _loadFavorites() async {
    try {
      final data = await DBService().fetchFavorites();
      setState(() {
        _favoriteCities = data;
      });

      _fetchWeatherData();
    } catch (e) {
      debugPrint("Error cargando favoritos: $e");
    }
  }

  // Método que llama a la API con las localizaciones favoritas
  Future<void> _fetchWeatherData() async {
    try {
      for (var city in _favoriteCities) {
        final weather = await ApiService().fetchWeatherCurrent(city['city_name']);

        // Verificar si el objeto weather tiene los datos esperados
        if (weather.forecast!.forecastday.isEmpty) {
          debugPrint("No se encontraron datos de pronóstico para ${city['city_name']}");
          continue;
        }

        setState(() {
          _weatherData[city['city_name']] = weather;
        });
      }
    } catch (e) {
      debugPrint("Error obteniendo datos del clima: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Limitar la lista de favoritos a los primeros 4 elementos
    final fourCities = _favoriteCities.take(4).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Localizaciones Favoritas',
                style: TextStyle(
                  color: AppColors.azulClaroWeather,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const FavoritasScreen()),
                  );
                },
                child: const Text(
                  'Ver todas',
                  style: TextStyle(
                    color: AppColors.blancoWeather,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: AppColors.azulClaroWeather),
            )
          else if (fourCities.isNotEmpty) ...[
            for (int i = 0; i < fourCities.length; i += 2)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWeatherWidget(fourCities[i]),
                    if (i + 1 < fourCities.length) _buildWeatherWidget(fourCities[i + 1]),
                  ],
                ),
              ),
          ] else ...[
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Text(
                  'No tienes localizaciones favoritas aún',
                  style: TextStyle(
                    color: AppColors.azulClaroWeather,
                    fontFamily: 'ReadexPro',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Widget para construir el contenedor del clima
  Widget _buildWeatherWidget(Map<String, dynamic> city) {
    final weather = _weatherData[city['city_name']];

    if (weather == null) {
      return const SizedBox.shrink();
    }
    
    return LocalizacionWidget(
      ciudad: city['city_name'],
      estadoClima: weather.current.condition.text,
      temperatura: weather.current.tempC.round(),
      location: weather.location,
      tamanyoLetra :14,
      tamanyoImagen: 40,
      tamanyoHeight: 80,
      tamanyoWidth: 170,
      tamanyoColumnaTexto: 100,
    );
  }
}