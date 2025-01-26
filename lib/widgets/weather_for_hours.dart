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
      height: 150.0, 
      child: ListView.builder(
        scrollDirection:
            Axis.horizontal, 
        itemCount:
            widget.weatherForHour.length, 
        itemBuilder: (context, index) {
          var weatherHour = widget.weatherForHour[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), 
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
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, 
                        children: [
                          Text(
                            '${weatherHour.temperatura.round()}°C',
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
                                weatherHour.estadoClima), 
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
          );
        },
      ),
    );
  }
}
