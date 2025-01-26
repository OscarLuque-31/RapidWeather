import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';

class CurrentWeatherBigWidget extends StatefulWidget {
  final String estadoClima;
  final int temperatura;

  const CurrentWeatherBigWidget({
    super.key,
    required this.estadoClima,
    required this.temperatura,
  });

  @override
  State<CurrentWeatherBigWidget> createState() => _CurrentWeatherBigWidget();
}

class _CurrentWeatherBigWidget extends State<CurrentWeatherBigWidget> {
  
  @override
  Widget build(BuildContext context) {
    // Widget que muestra el estado del clima y la temperatura actual
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Utils.determinarClima(widget.estadoClima),
            width: 130,
          ),
          Text(
            "${widget.temperatura}°C",
            style: const TextStyle(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w300,
              fontSize: 60,
              color: AppColors.blancoWeather,
            ),
          ),
        ],
      ),
    );
  }
}
