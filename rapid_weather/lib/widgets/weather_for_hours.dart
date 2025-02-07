import 'package:flutter/material.dart';
import 'package:rapid_weather/models/forecast_day.dart';
import 'package:rapid_weather/models/hour.dart';
import 'package:rapid_weather/models/weather_response.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';
import 'package:rapid_weather/widgets/especificaciones_clima_hora.dart';
import 'package:rapid_weather/widgets/especificaciones_clima_dia.dart';

class WeatherForHoursAndDays extends StatefulWidget {
  final WeatherResponse weatherResponse;
  final bool especificaciones;
  final bool mostrarPronostico;

  const WeatherForHoursAndDays({
    super.key,
    required this.weatherResponse,
    required this.especificaciones,
    required this.mostrarPronostico,
  });

  @override
  State<WeatherForHoursAndDays> createState() => _WeatherForHoursAndDaysState();
}

class _WeatherForHoursAndDaysState extends State<WeatherForHoursAndDays> {
  Hour? weatherSeleccionado;
  ForecastDay? forecastDaySeleccionado;
  int selectedDayIndex = 0; 

  @override
  void initState() {
    super.initState();
    // Por defecto, muestra la primera hora
    if (widget.weatherResponse.forecast!.forecastday.isNotEmpty) {
      forecastDaySeleccionado =
          widget.weatherResponse.forecast!.forecastday[0];
      if (forecastDaySeleccionado!.hour.isNotEmpty) {
        weatherSeleccionado = forecastDaySeleccionado!.hour.first;
      }
    }
  }

  // Método para cambiar el pronóstico seleccionado
  void _cambiarPronostico(int index) {
    setState(() {
      selectedDayIndex = index;
      forecastDaySeleccionado =
          widget.weatherResponse.forecast!.forecastday[index];
      weatherSeleccionado = forecastDaySeleccionado!.hour.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.mostrarPronostico)
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _cambiarPronostico(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedDayIndex == 0
                          ? AppColors.azulGrisaceoWeather
                          : Colors.transparent, 
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Hoy",
                      style: TextStyle(
                        fontFamily: 'ReadexPro',
                        color: AppColors.blancoWeather,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _cambiarPronostico(1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedDayIndex == 1
                          ? AppColors.azulGrisaceoWeather
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Mañana",
                      style: TextStyle(
                        fontFamily: 'ReadexPro',
                        color: AppColors.blancoWeather,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _cambiarPronostico(2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: selectedDayIndex == 2
                          ? AppColors.azulGrisaceoWeather
                          : Colors.transparent, 
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Pasado mañana",
                      style: TextStyle(
                        fontFamily: 'ReadexPro',
                        color: AppColors.blancoWeather,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Contenedor para las horas del pronóstico
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 140.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: forecastDaySeleccionado?.hour.length ?? 0,
            itemBuilder: (context, index) {
              var weatherHour = forecastDaySeleccionado!.hour[index];

              return GestureDetector(
                onTap: widget.especificaciones
                    ? () {
                        setState(() {
                          weatherSeleccionado = weatherHour;
                        });
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60.0,
                        height: 100.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.azulGrisaceoWeather,
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                              color: widget.especificaciones &&
                                      weatherSeleccionado == weatherHour
                                  ? AppColors.azulClaroWeather
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${weatherHour.tempC.round()}°C',
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
                                      weatherHour.condition.text),
                                  width: 30.0,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '$index:00',
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
                ),
              );
            },
          ),
        ),

        // Muestra siempre EspecificacionesClimaHora con la primera hora seleccionada por defecto
        if (widget.especificaciones && weatherSeleccionado != null)
          EspecificacionesClimaHora(hour: weatherSeleccionado!),

        if (widget.especificaciones) const SizedBox(height: 20),

        // Especificaciones del clima del día
        if (widget.especificaciones && forecastDaySeleccionado != null)
          EspecificacionesClimaDia(day: forecastDaySeleccionado!.day),
      ],
    );
  }
}
