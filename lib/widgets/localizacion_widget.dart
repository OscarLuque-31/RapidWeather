import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';

class LocalizacionWidget extends StatefulWidget {
  final String ciudad;
  final String estadoClima;
  final int temperatura;

  const LocalizacionWidget(
      {super.key,
      required this.ciudad,
      required this.estadoClima,
      required this.temperatura});

  @override
  State<LocalizacionWidget> createState() => _LocalizacionWidgetState();
}

class _LocalizacionWidgetState extends State<LocalizacionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, 
      width: 170,
      decoration: BoxDecoration(
        color: AppColors.azulGrisaceoWeather,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: <Widget>[
              Text(
                '${widget.temperatura.round()} °C',
                style: const TextStyle(
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: AppColors.blancoWeather,
                ),
              ),
              const SizedBox(height: 5), 
              Text(
                widget.ciudad,
                style: const TextStyle(
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: AppColors.azulClaroWeather,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Image.asset(
            Utils.determinarClima(widget.estadoClima),
            width: 40,
          ),
        ],
      ),
    );
  }
}
