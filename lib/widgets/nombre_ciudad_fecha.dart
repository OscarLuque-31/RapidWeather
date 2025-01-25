import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class NombreCiudadFecha extends StatefulWidget {

  final String nombreCiudad;
  final String fechaActual;

  const NombreCiudadFecha({
    super.key,
    required this.nombreCiudad,
    required this.fechaActual,
  });

  @override
  State<NombreCiudadFecha> createState() => _NombreCiudadFecha();
}

class _NombreCiudadFecha extends State<NombreCiudadFecha> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.nombreCiudad,
            style: const TextStyle(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w300,
              fontSize: 30,
              color: AppColors.azulClaroWeather,
              ),
          ),
          Text(
            widget.fechaActual,
            style: const TextStyle(
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w300,
              fontSize: 13,
              color: AppColors.blancoWeather,
              ),
          ),
        ],
      ),
    );
  }
  
}