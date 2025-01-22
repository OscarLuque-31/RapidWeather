import 'package:flutter/material.dart';

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
          color: Color(0xFF090C37),
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0XFFEAEAEA),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xFF090C37),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Color(0xFF090C37),
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Color(0xFF3478F6),
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
