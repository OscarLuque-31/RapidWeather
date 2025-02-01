import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/services/bbdd_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/widgets/custom_date_picker_text_field.dart';
import 'package:rapid_weather/widgets/custom_text_field.dart';

class DatosScreen extends StatefulWidget {
  const DatosScreen({super.key});

  @override
  State<DatosScreen> createState() => _DatosScreenState();
}

class _DatosScreenState extends State<DatosScreen> {
  String nombreUsuario = "";
  String nombre = "";
  String apellidos = "";
  String fechaNacimiento = "";

  @override
  void initState() {
    super.initState();
  }

  // Verificar si los datos están completos
  bool _areFieldsComplete() {
    return nombreUsuario.isNotEmpty &&
        nombre.isNotEmpty &&
        apellidos.isNotEmpty &&
        fechaNacimiento.isNotEmpty;
  }

  // Guardar los datos en la base de datos
  Future<void> _saveUserData() async {
    await DBService().insertUser(
      username: nombreUsuario,
      name: nombre,
      surname: apellidos,
      birthDate: fechaNacimiento,
    );

    // Actualizamos el estado de registro a verdadero
    await DBService().updateRegistrationStatus(true);

    // Verificamos si el widget aún está montado antes de intentar navegar
    if (mounted) {
      // Solo realizamos la navegación si el widget sigue montado
      Navigator.pushReplacementNamed(context, AppRoutes.principal);
    }
  }

  // Guardar los datos y navegar a la pantalla principal
  Future<void> saveUserAndNavigate() async {
  // Guardamos los datos en la base de datos
  await _saveUserData();

  // Navegamos a la pantalla principal si el widget sigue montado
  if (mounted) {
    Navigator.pushReplacementNamed(context, AppRoutes.principal);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Permite que el contenido se desplace cuando se muestre el teclado
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height:
                  MediaQuery.of(context).size.height * 0.395,
              child: Center(
                child: Image.asset(
                  'assets/images/logo_rapid_weather.png',
                  width: 300,
                ),
              ),
            ),
            const Text(
              "Información requerida",
              style: TextStyle(
                fontFamily: 'ReadexPro',
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: AppColors.azulClaroWeather,
              ),
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center, 
              child: Container(
                margin: const EdgeInsets.all(16.0),
                width: 360,
                height: 400, 
                decoration: BoxDecoration(
                  color: AppColors.azulGrisaceoWeather,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      width: 315,
                      height: 62,
                      hintText: "Nombre de usuario",
                      onChanged: (value) =>
                          setState(() => nombreUsuario = value),
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      width: 315,
                      height: 62,
                      hintText: "Nombre",
                      onChanged: (value) => setState(() => nombre = value),
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextField(
                      width: 315,
                      height: 62,
                      hintText: "Apellidos",
                      onChanged: (value) => setState(() => apellidos = value),
                    ),
                    const SizedBox(height: 10.0),
                    CustomDatePickerTextField(
                      width: 315,
                      height: 62,
                      hintText: "Fecha de nacimiento",
                      onChanged: (value) =>
                          setState(() => fechaNacimiento = value),
                    ),
                    const SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_areFieldsComplete()) {
                          saveUserAndNavigate();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Row(
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Por favor, completa todos los campos.',
                                      style: TextStyle(
                                        fontFamily: 'ReadexPro',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.azulGrisaceoWeather,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.only(
                                  bottom: 450, left: 16, right: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.azulOscuroWeather,
                        minimumSize: const Size(315, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      child: const Text(
                        "Empezar",
                        style: TextStyle(
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.blancoWeather,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
