import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/services/bbdd_service.dart';

class NombreCiudadFecha extends StatefulWidget {
  final String nombreCiudad;
  final String fechaActual;
  final bool mostrarEstrella;
  final Location? location;

  const NombreCiudadFecha({
    super.key,
    required this.nombreCiudad,
    required this.fechaActual,
    required this.mostrarEstrella,
    this.location,
  });

  @override
  State<NombreCiudadFecha> createState() => _NombreCiudadFecha();
}

class _NombreCiudadFecha extends State<NombreCiudadFecha> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = false;
    _checkIfFavorite(); 
  }

  // Función para comprobar si la ciudad está en favoritos
  Future<void> _checkIfFavorite() async {
    if (widget.location != null) {
      bool favorite = await DBService().isCityFavorite(
        widget.location!.name, 
        widget.location!.lat, 
        widget.location!.lon
      );

      setState(() {
        isFavorite = favorite; 
      });
    }
  }

  // Función para manejar el clic en la estrella y actualizar la base de datos
  Future<void> toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite; 
    });

    if (isFavorite) {
      await DBService().insertFavorite(
        widget.nombreCiudad, 
        widget.location!.lat, 
        widget.location!.lon
      );
    } else {
      await DBService().deleteFavorite(
        widget.nombreCiudad, 
        widget.location!.lat, 
        widget.location!.lon
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370, 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: Text(
                    widget.nombreCiudad,
                    overflow: TextOverflow.ellipsis, 
                    maxLines: 2, 
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                      color: AppColors.azulClaroWeather,
                    ),
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
          ),
          const Spacer(),
          if (widget.mostrarEstrella)
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: AppColors.azulClaroWeather,
                    size: 30,
                  ),
                  onPressed: toggleFavorite,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
