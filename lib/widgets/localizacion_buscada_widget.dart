import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class LocalizacionBuscadaWidget extends StatefulWidget {
  final Location location;

  const LocalizacionBuscadaWidget({
    super.key,
    required this.location,
  });

  @override
  State<LocalizacionBuscadaWidget> createState() =>
      _LocalizacionBuscadaWidgetState();
}

class _LocalizacionBuscadaWidgetState extends State<LocalizacionBuscadaWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.climaPronosticoCiudad, arguments: widget.location);
      }, 
      child: Card(
        color: AppColors
            .azulGrisaceoWeather, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 23),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          leading: const Icon(
            Icons.location_on,
            color: AppColors.azulOscuroWeather,
            size: 36,
          ),
          title: Text(
            widget.location.name,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.azulClaroWeather,
              fontFamily: 'ReadexPro',
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: Text(
            '${widget.location.region}, ${widget.location.country}',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.blancoWeather,
            ),
          ),
        ),
      ),
    );
  }
}
