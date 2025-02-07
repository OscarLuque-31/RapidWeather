import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/utils/utils.dart';

class LocalizacionWidget extends StatefulWidget {
  final String ciudad;
  final String estadoClima;
  final int temperatura;
  final Location location;
  final double tamanyoLetra;
  final double tamanyoImagen;
  final double tamanyoWidth;
  final double tamanyoHeight;
  final double tamanyoColumnaTexto;

  const LocalizacionWidget({
    super.key,
    required this.ciudad,
    required this.estadoClima,
    required this.temperatura,
    required this.location,
    required this.tamanyoImagen,
    required this.tamanyoLetra,
    required this.tamanyoHeight,
    required this.tamanyoWidth,
    required this.tamanyoColumnaTexto
  });

  @override
  State<LocalizacionWidget> createState() => _LocalizacionWidgetState();
}

class _LocalizacionWidgetState extends State<LocalizacionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Al tocar el widget, navega a la pantalla de clima
        Navigator.pushNamed(context, AppRoutes.climaPronosticoCiudad, arguments: widget.location);
      },
      child: Container(
        height: widget.tamanyoHeight,
        width: widget.tamanyoWidth,
        decoration: BoxDecoration(
          color: AppColors.azulGrisaceoWeather,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: widget.tamanyoColumnaTexto, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Temperatura
                  Text(
                    '${widget.temperatura.round()} °C',
                    style: TextStyle(
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w300,
                      fontSize: widget.tamanyoLetra,
                      color: AppColors.blancoWeather,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Ciudad
                  Text(
                    widget.ciudad,
                    overflow: TextOverflow.ellipsis, 
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w500,
                      fontSize: widget.tamanyoLetra,
                      color: AppColors.azulClaroWeather,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              Utils.determinarClima(widget.estadoClima),
              width: widget.tamanyoImagen,
            ),
          ],
        ),
      ),
    );
  }
}
