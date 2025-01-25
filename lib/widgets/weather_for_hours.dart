import 'package:flutter/material.dart';
import 'package:rapid_weather/models/weather_hour.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';

class WeatherForHours extends StatefulWidget {
  final List<WeatherHour> weatherForHour;

  const WeatherForHours({
    super.key,
    required this.weatherForHour,
  });

  @override
  State<WeatherForHours> createState() => _WeatherForHoursState();
}

class _WeatherForHoursState extends State<WeatherForHours> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 150.0, // Ajusta el alto del contenedor según lo que necesites
      child: ListView.builder(
        scrollDirection:
            Axis.horizontal, // Para hacer que el ListView sea horizontal
        itemCount:
            widget.weatherForHour.length, // Número de elementos en la lista
        itemBuilder: (context, index) {
          var weatherHour = widget.weatherForHour[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Espaciado entre los items
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // la hora en formato "0", "1", "2", ..., "23"

                SizedBox(
                  width: 60.0, // Ajusté el tamaño para que sea más espacioso
                  height: 100.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.azulGrisaceoWeather,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      // Asegura que el contenido esté centrado
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centra el contenido verticalmente
                        children: [
                          Text(
                            '${weatherHour.temperatura.round()}°C', // Temperatura de la hora
                            style: const TextStyle(
                              fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: AppColors.blancoWeather,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Image.asset(
                            Utils.determinarClima(
                                weatherHour.estadoClima), // Icono de la hora
                            width: 30.0, // Ajusté el tamaño del icono
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '$index:00', // Usa el índice para generar la hora (0 a 23)
                            style: const TextStyle(
                              fontFamily: 'ReadexPro',
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                              color: AppColors.blancoWeather,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
