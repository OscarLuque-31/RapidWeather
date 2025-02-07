import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class BarraBuscar extends StatelessWidget {
  final Function(String) onSearch;

  const BarraBuscar({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return SizedBox(
      height: 60,
      width: 350,
      child: TextField(
        controller: searchController,
        onSubmitted: onSearch, 
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.azulOscuroWeather, 
          hintText: 'Buscar una ciudad',
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: IconButton(
            icon: const Icon(Icons.search, color: AppColors.azulGrisaceoWeather),
            onPressed: () => onSearch(searchController.text),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: AppColors.azulGrisaceoWeather,
              width: 2,
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
        style: const TextStyle(
          color: AppColors.azulClaroWeather,
          fontFamily: 'ReadexPro',
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
