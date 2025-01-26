import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';
import 'package:rapid_weather/widgets/drawer.dart';
import 'package:rapid_weather/widgets/nombre_ciudad_fecha.dart';
import 'package:rapid_weather/widgets/localizaciones_favoritas.dart';
import 'package:rapid_weather/widgets/current_weather_big.dart';
import 'package:rapid_weather/widgets/weather_for_hours.dart';
import 'package:rapid_weather/services/api_service.dart';
import 'package:rapid_weather/models/weather.dart';
import 'package:geolocator/geolocator.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  Future<Weather>? _weatherData;
  late String fechaActual;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    fechaActual = Utils.obtenerFechaActual();
    checkAndRequestPermission(); // Llamar a checkAndRequestPermission() para solicitar permisos
  }

  // Verificar y solicitar permisos para obtener la ubicación
  Future<void> checkAndRequestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        // Si los servicios están deshabilitados, mostrar mensaje al usuario
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Los servicios de ubicación están deshabilitados.')),
        );
      }
      return;
    }

    // Verificar los permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Si el permiso es denegado, solicitarlo
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          // Si el permiso sigue siendo denegado, mostrar mensaje al usuario
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Permiso de ubicación denegado.')),
          );
        }
        return;
      }
    }

    // Continuar con la obtención de la ubicación si se tienen los permisos
    _initializeWeatherData();
  }

  // Inicializar la obtención de ubicación y clima
  Future<void> _initializeWeatherData() async {
    try {
      // Intentar obtener la última ubicación conocida
      Position? lastKnownPosition = await Geolocator.getLastKnownPosition();

      if (lastKnownPosition != null) {
        latitude = lastKnownPosition.latitude;
        longitude = lastKnownPosition.longitude;
      } else {
        // Si no hay última ubicación conocida, obtener una nueva
        Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        latitude = currentPosition.latitude;
        longitude = currentPosition.longitude;
      }

      // Construir la cadena de latitud y longitud
      String latLongString = '$latitude, $longitude';

      // Cargar los datos del clima
      setState(() {
        _weatherData = ApiService().fetchWeatherForOneDay(latLongString);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener la ubicación: $e')),
        );
      }
    }
  }

  // Construir el cuerpo de la pantalla
  Widget _buildBody() {
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

    return FutureBuilder<Weather>(
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
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No se pudo obtener el clima.'));
        } else {
          var weatherToday = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NombreCiudadFecha(
                nombreCiudad: weatherToday.ciudad,
                fechaActual: fechaActual,
              ),
              CurrentWeatherBigWidget(
                estadoClima: weatherToday.estadoClima,
                temperatura: weatherToday.temperatura.round(),
              ),
              WeatherForHours(weatherForHour: weatherToday.horas),
              const LocalizacionesFavoritas(),
            ],
          );
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
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
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
      drawer: const WidgetDrawer(),
      body: _buildBody(),
      bottomNavigationBar: Container(
        height: 60,
        alignment: Alignment.topCenter,
        color: AppColors.azulOscuroWeather,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_outline_sharp,
                  size: 27, color: AppColors.blancoWeather),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined,
                  size: 25, color: AppColors.blancoWeather),
            ),
          ],
        ),
      ),
    );
  }
}
