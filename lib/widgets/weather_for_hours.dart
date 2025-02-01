import 'package:flutter/material.dart';
import 'package:rapid_weather/models/forecast_day.dart';
import 'package:rapid_weather/models/hour.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';
import 'package:rapid_weather/widgets/especificaciones_clima_hora.dart';
import 'package:rapid_weather/widgets/especificaciones_clima_dia.dart'; // Importa el widget de EspecificacionesClimaDia

class WeatherForHoursAndDays extends StatefulWidget {
  final ForecastDay forecastDay;
  final bool especificaciones;

  const WeatherForHoursAndDays({
    super.key,
    required this.forecastDay,
    required this.especificaciones,
  });

  @override
  State<WeatherForHoursAndDays> createState() => _WeatherForHoursAndDaysState();
}

class _WeatherForHoursAndDaysState extends State<WeatherForHoursAndDays> {
  Hour? weatherSeleccionado;

  @override
  void initState() {
    super.initState();
    // Por defecto, mostrar la primera hora
    if (widget.forecastDay.hour.isNotEmpty) {
      weatherSeleccionado = widget.forecastDay.hour.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Eliminamos SingleChildScrollView
      children: [
        // Lista horizontal de las horas
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 140.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.forecastDay.hour.length,
            itemBuilder: (context, index) {
              var weatherHour = widget.forecastDay.hour[index];

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
                                  : Colors
                                      .transparent, // Resalta la seleccionada solo si especificaciones es true
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
        if (widget.especificaciones)
          EspecificacionesClimaDia(day: widget.forecastDay.day),
      ],
    );
  }
}
