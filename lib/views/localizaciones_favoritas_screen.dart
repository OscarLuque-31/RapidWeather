import 'package:flutter/material.dart';
import 'package:rapid_weather/models/weather_response.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/services/api_service.dart';
import 'package:rapid_weather/services/bbdd_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/widgets/localizacion_widget.dart';

class FavoritasScreen extends StatefulWidget {
  const FavoritasScreen({super.key});

  @override
  State<FavoritasScreen> createState() => _FavoritasScreenState();
}

class _FavoritasScreenState extends State<FavoritasScreen> {
  List<Map<String, dynamic>> _favoriteCities = [];
  final Map<String, WeatherResponse> _weatherData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Método que carga las ciudades favoritas desde base de datos 
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

  // Método que llama a la API de las ciudades favoritas del usuario
  Future<void> _fetchWeatherData() async {
    try {
      for (var city in _favoriteCities) {
        final weather =
            await ApiService().fetchWeatherCurrent(city['city_name']);

        if (weather.forecast!.forecastday.isEmpty) {
          debugPrint(
              "No se encontraron datos de pronóstico para ${city['city_name']}");
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
    return Scaffold(
      backgroundColor: AppColors.azulOscuroWeather,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.azulClaroWeather,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.principal);
                  },
                );
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    color: AppColors.azulClaroWeather),
              )
            : _favoriteCities.isEmpty
                ? const Center(
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
                  )
                : Column(
                    children: [
                      Expanded(
                        // Ahora dentro de Column
                        child: ListView.builder(
                          itemCount: _favoriteCities.length,
                          itemBuilder: (context, index) {
                            final city = _favoriteCities[index];
                            return _buildWeatherWidget(city);
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  // Método que construye el pequeño widget de la ciudad favorita
  Widget _buildWeatherWidget(Map<String, dynamic> city) {
    final weather = _weatherData[city['city_name']];

    if (weather == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: LocalizacionWidget(
        ciudad: city['city_name'],
        estadoClima: weather.current.condition.text,
        temperatura: weather.current.tempC.round(),
        location: weather.location,
        tamanyoLetra: 20,
        tamanyoImagen: 80,
        tamanyoHeight: 130,
        tamanyoWidth: 160,
        tamanyoColumnaTexto: 200,
      ),
    );
  }
}
