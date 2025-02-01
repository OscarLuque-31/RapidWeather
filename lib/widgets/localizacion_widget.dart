import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';

class LocalizacionWidget extends StatefulWidget {
  final String ciudad;
  final String estadoClima;
  final int temperatura;

  const LocalizacionWidget({
    super.key,
    required this.ciudad,
    required this.estadoClima,
    required this.temperatura,
  });

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
          // Columna para el texto (temperatura y ciudad)
          SizedBox(
            width: 100, // Ancho fijo para la columna de texto
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Temperatura
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
                // Ciudad
                Text(
                  widget.ciudad,
                  overflow: TextOverflow.ellipsis, // Puntos suspensivos si el texto es largo
                  maxLines: 1, // Solo una línea de texto
                  style: const TextStyle(
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.azulClaroWeather,
                  ),
                ),
              ],
            ),
          ),
          // Imagen del clima
          Image.asset(
            Utils.determinarClima(widget.estadoClima),
            width: 40,
          ),
        ],
      ),
    );
  }
}