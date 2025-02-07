import 'package:flutter/material.dart';
import 'package:rapid_weather/models/weather_response.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';
import 'package:rapid_weather/widgets/drawer.dart';
import 'package:rapid_weather/widgets/nombre_ciudad_fecha.dart';
import 'package:rapid_weather/widgets/localizaciones_favoritas.dart';
import 'package:rapid_weather/widgets/current_weather_big.dart';
import 'package:rapid_weather/widgets/weather_for_hours.dart';
import 'package:rapid_weather/services/api_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  Future<WeatherResponse>? weatherData;
  late String fechaActual;
  double latitude = 0.0;
  double longitude = 0.0;
  bool isFirstTime = false;

  @override
  void initState() {
    super.initState();
    fechaActual = Utils.obtenerFechaActual();
    checkAndRequestPermission();
    _checkFirstTime();
  }

  // Método que checkea si es la primera que entra en la aplicación y guarda el estado
  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time') ?? true;

    if (firstTime) {
      setState(() {
        isFirstTime = true;
      });
      prefs.setBool(
          'first_time', false); // Establece que ya no es la primera vez
      _setAsRootScreen(); // Limpiar el stack de navegación
    }
  }

  // Limpia el stack de pantallas
  Future<void> _setAsRootScreen() async {
    if (Navigator.canPop(context)) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const PrincipalScreen()),
        (Route<dynamic> route) =>
            false, // Elimina todas las pantallas anteriores
      );
    }
  }

  // Método que checkea si tiene o no permisos de geolocalización y si no los tiene los pide
  Future<void> checkAndRequestPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Los servicios de ubicación están deshabilitados.')),
        );
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
              'Permiso de ubicación denegado.',
              style: TextStyle(
                fontFamily: 'ReadexPro',
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: AppColors.azulClaroWeather,
              ),
            )),
          );
        }
        return;
      }
    }

    _initializeWeatherData();
  }

  // Método que inicializa el tiempo desde una llamada a la API con la geolocalización
  Future<void> _initializeWeatherData() async {
    try {
      Position? lastKnownPosition = await Geolocator.getLastKnownPosition();

      if (lastKnownPosition != null) {
        latitude = lastKnownPosition.latitude;
        longitude = lastKnownPosition.longitude;
      } else {
        Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        latitude = currentPosition.latitude;
        longitude = currentPosition.longitude;
      }

      String latLongString = '$latitude, $longitude';

      setState(() {
        weatherData = ApiService().fetchWeatherForThreeDays(latLongString);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
            'Error al obtener la ubicación: $e',
            style: const TextStyle(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w300,
              fontSize: 10,
              color: AppColors.azulClaroWeather,
            ),
          )),
        );
      }
    }
  }

  // Método que construye el cuerpo de la pantalla principal
  Widget buildBody() {
    if (weatherData == null) {
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
      future: weatherData,
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
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(
              color: AppColors.azulClaroWeather,
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No se pudo obtener el clima.'));
        } else {
          var weatherToday = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                NombreCiudadFecha(
                  nombreCiudad: weatherToday.location.name,
                  fechaActual: fechaActual,
                  mostrarEstrella: false,
                ),
                CurrentWeatherBigWidget(
                  estadoClima: weatherToday.current.condition.text,
                  temperatura: weatherToday.current.tempC.round(),
                  mostrarPronostico: true,
                  location: weatherToday.location,
                ),
                WeatherForHoursAndDays(
                  weatherResponse: weatherToday,
                  mostrarPronostico: false,
                  especificaciones: false,
                ),
                const LocalizacionesFavoritas(),
                const SizedBox(height: 20),
              ],
            ),
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
      body: buildBody(),
    );
  }
}
