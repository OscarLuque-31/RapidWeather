import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final double width; // Ancho del TextField
  final double height; // Alto del TextField
  final String hintText; // Texto del placeholder

  const CustomTextField({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        style: const TextStyle(
          fontFamily: 'ReadexPro',
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.azulOscuroWeather,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.blancoWeather,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.azulOscuroWeather,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: AppColors.azulOscuroWeather,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: AppColors.azulClaroWeather,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
