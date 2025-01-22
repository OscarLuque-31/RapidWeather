import 'package:flutter/material.dart';

class CustomDatePickerTextField extends StatefulWidget {
  final double width; // Ancho del campo
  final double height; // Alto del campo
  final String hintText; // Placeholder inicial

  const CustomDatePickerTextField({
    super.key,
    required this.width,
    required this.height,
    required this.hintText,
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context), // Mostrar el DatePicker al tocar el campo
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: TextField(
          enabled: false, // Evita la edición manual
          style: const TextStyle(
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xFF090C37),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEAEAEA),
            hintText: _selectedDate ?? widget.hintText, // Muestra la fecha seleccionada o el placeholder
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
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: Color(0xFF090C37),
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
