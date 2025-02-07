import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';

class CurrentWeatherBigWidget extends StatefulWidget {
  final String estadoClima;
  final int temperatura;
  final bool mostrarPronostico;
  final Location location;

  const CurrentWeatherBigWidget({
    super.key,
    required this.estadoClima,
    required this.temperatura,
    required this.mostrarPronostico,
    required this.location
  });

  @override
  State<CurrentWeatherBigWidget> createState() =>
      _CurrentWeatherBigWidget();
}

class _CurrentWeatherBigWidget extends State<CurrentWeatherBigWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
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

        if (widget.mostrarPronostico)
        Container(
          height: 38,
          width: double.infinity, 
          padding: const EdgeInsets.symmetric(horizontal: 17), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.date_range_rounded, color: AppColors.azulClaroWeather, size: 25),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.climaPronosticoDiasCiudad, arguments: widget.location);
                },
                child: const Text(
                  "Pronóstico",
                  style: TextStyle(
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: AppColors.azulClaroWeather,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
  
    );
  }
}
