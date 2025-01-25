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

class PrincipalScreen extends StatefulWidget {
  const PrincipalScreen({super.key});

  @override
  State<PrincipalScreen> createState() => _PrincipalScreenState();
}

class _PrincipalScreenState extends State<PrincipalScreen> {
  late Future<Weather> _weatherData; // Variable para almacenar los datos del clima
  String ciudad = "Madrid"; // Nombre de la ciudad
  late String fechaActual; // Fecha dinámica

  @override
  void initState() {
    super.initState();
    fechaActual = Utils.obtenerFechaActual(); // Inicializa la fecha actual
    _weatherData = ApiService().fetchWeatherForOneDay(ciudad); // Obtiene los datos del clima
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Quita la flecha hacia atrás
        title: Row(
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu), // Ícono de hamburguesa
                  onPressed: () {
                    Scaffold.of(context).openDrawer(); // Abre el Drawer cuando se toque el ícono
                  },
                );
              },
            ),
            const Spacer(), // Empuja la imagen hacia la derecha
            Image.asset(
              'assets/images/small_logo.png',
              width: 40,
            ),
          ],
        ),
      ),
      drawer: const WidgetDrawer(),
      body: FutureBuilder<Weather>(
        future: _weatherData, // La llamada a la API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.azulClaroWeather,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.azulGrisaceoWeather),
              ),
            ); // Espera mientras carga
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Muestra el error
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se pudo obtener el clima.'));
          } else {
            var weatherToday = snapshot.data!; // Datos del clima actual

            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NombreCiudadFecha(
                    nombreCiudad: ciudad, // Ciudad dinámica
                    fechaActual: fechaActual, // Fecha dinámica
                  ),
                  CurrentWeatherBigWidget(
                    estadoClima: weatherToday.estadoClima, // Estado del clima actual
                    temperatura: weatherToday.temperatura.round(),
                  ),
                  WeatherForHours(weatherForHour: weatherToday.horas), // Pronóstico por horas
                  const LocalizacionesFavoritas(),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        alignment: Alignment.topCenter,
        color: AppColors.azulOscuroWeather,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_outline_sharp, size: 27, color: AppColors.blancoWeather),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined, size: 25, color: AppColors.blancoWeather),
            ),
          ],
        ),
      ),
    );
  }
}
