import 'package:flutter/material.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class CustomDatePickerTextField extends StatefulWidget {
  final double width;
  final double height; 
  final String hintText; 
  final Function(String)? onChanged;

  const CustomDatePickerTextField({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
    this.onChanged, 
  });

  @override
  State<CustomDatePickerTextField> createState() => _CustomDatePickerTextFieldState();
}

class _CustomDatePickerTextFieldState extends State<CustomDatePickerTextField> {
  String? _selectedDate; // Fecha seleccionada

  // Método para abrir el DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(1900), // Primera fecha seleccionable
      lastDate: DateTime(2100), // Última fecha seleccionable
    );

    // Verifica si se seleccionó una fecha
    if (picked != null) {
      setState(() {
        _selectedDate = "${picked.day}/${picked.month}/${picked.year}";
      });

      // Llama al callback si no es null
      if (widget.onChanged != null) {
        widget.onChanged!(_selectedDate!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context), 
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextField(
          enabled: false,
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.azulOscuroWeather,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.blancoWeather,
            hintText: _selectedDate ?? widget.hintText, 
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
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: AppColors.azulOscuroWeather,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
