import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class BarraBuscar extends StatefulWidget {
  const BarraBuscar({super.key});

  @override
  State<BarraBuscar> createState() => _BarraBuscarState();
}

class _BarraBuscarState extends State<BarraBuscar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.azulOscuroWeather, // Color de fondo (oscuro).
              hintText: 'Buscar una ciudad',
              hintStyle: const TextStyle(color: Colors.white70),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.azulGrisaceoWeather,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.azulGrisaceoWeather, // Color del borde.
                  width: 2, // Ancho del borde.
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.azulGrisaceoWeather, 
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: const BorderSide(
                  color: AppColors.azulClaroWeather, 
                  width: 2,
                ),
              ),
            ),
            style: const TextStyle(color:AppColors.azulClaroWeather, fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.w300,),
          ),
        ],
      ),  
    );
  }
}
