import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/models/weather_response.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/services/api_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';
import 'package:rapid_weather/widgets/current_weather_big.dart';
import 'package:rapid_weather/widgets/nombre_ciudad_fecha.dart';
import 'package:rapid_weather/widgets/weather_for_hours.dart';

class ClimaPronosticoDiasCiudad extends StatefulWidget {
  const ClimaPronosticoDiasCiudad({super.key});

  @override
  State<ClimaPronosticoDiasCiudad> createState() =>
      _ClimaPronosticoDiasCiudadState();
}

class _ClimaPronosticoDiasCiudadState extends State<ClimaPronosticoDiasCiudad> {
  Future<WeatherResponse>? _weatherData;
  late String fechaActual;
  late Location location;

  @override
  void initState() {
    super.initState();
    fechaActual = Utils.obtenerFechaActual();

    Future.microtask(() {
      if (mounted) {
        final args = ModalRoute.of(context)!.settings.arguments as Location;

        setState(() {
          location = args;
        });
      }

      // Cargar los datos del clima
      initializeWeatherData();
    });
  }

  // Método que inicializa la obtención de ubicación y clima
  Future<void> initializeWeatherData() async {
    try {
      String latLongString = '${location.lat}, ${location.lon}';
      setState(() {
        _weatherData = ApiService().fetchWeatherForThreeDays(latLongString);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener la ubicación: $e')),
        );
      }
    }
  }

  // Método que construye el cuerpo de la pantalla
  Widget buildBody() {
    if (_weatherData == null) {
      return const Center(
        child: Text(
          'Cargando los datos...',
          style: TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w300,
            fontSize: 20,
            color: AppColors.azulClaroWeather,
          ),
        ),
      );
    }

    return FutureBuilder<WeatherResponse>(
      future: _weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: AppColors.azulClaroWeather,
              valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.azulGrisaceoWeather),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No se pudo obtener el clima.'));
        } else {
          var weatherResponse = snapshot.data!;
          var weatherCurrent = weatherResponse.current;

          return SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NombreCiudadFecha(
                nombreCiudad: location.name,
                fechaActual: fechaActual,
                mostrarEstrella: true,
                location: location,
              ),
              CurrentWeatherBigWidget(
                estadoClima: weatherCurrent.condition.text,
                temperatura: weatherCurrent.tempC.round(),
                mostrarPronostico: false,
                location: location,
              ),
              WeatherForHoursAndDays(
                mostrarPronostico: true,
                especificaciones: true,
                weatherResponse: weatherResponse,
              ),
              const SizedBox(height: 30)
            ],
          ));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.pushNamed(context, AppRoutes.principal);
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
        backgroundColor: AppColors.azulOscuroWeather,
      ),
      body: buildBody(),
    );
  }
}
