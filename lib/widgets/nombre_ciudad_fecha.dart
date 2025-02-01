import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/services/bbdd_service.dart'; // Asegúrate de importar el servicio que maneja los favoritos

class NombreCiudadFecha extends StatefulWidget {
  final String nombreCiudad;
  final String fechaActual;
  final bool mostrarEstrella; // Cambié el tipo a bool
  final Location? location;

  const NombreCiudadFecha({
    super.key,
    required this.nombreCiudad,
    required this.fechaActual,
    required this.mostrarEstrella,
    this.location
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
  }

  Future<void> toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite; // Cambiar el estado de la estrella
    });

    if (isFavorite) {
      await DBService().insertFavorite(widget.nombreCiudad, widget.location!.lat,
          widget.location!.lon); 
    } else {
      await DBService().deleteFavorite(widget.nombreCiudad, widget.location!.lat,
          widget.location!.lon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370, // Asegúrate de que el contenedor tenga un ancho definido
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 📌 Agregamos margen a la izquierda del texto
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Ajustamos el texto para que ocupe solo 2 líneas como máximo
                SizedBox(
                  width: 250, // Ajustamos un tamaño fijo para que el texto se ajuste
                  child: Text(
                    widget.nombreCiudad,
                    overflow: TextOverflow.ellipsis, // Agrega elipsis si el texto es muy largo
                    maxLines: 2, // Máximo de 2 líneas
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
