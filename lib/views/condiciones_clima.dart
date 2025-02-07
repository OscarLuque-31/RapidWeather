import 'package:flutter/material.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/utils/app_colors.dart';

class CondicionesClimaScreen extends StatefulWidget {
  const CondicionesClimaScreen({super.key});

  @override
  State<CondicionesClimaScreen> createState() => _CondicionesClimaScreenState();
}

class _CondicionesClimaScreenState extends State<CondicionesClimaScreen> {
  final Map<String, String> climaImagenes = {
    "Soleado": "assets/images/soleado.png",
    "Parcialmente nublado": "assets/images/parcialmente-nublado.png",
    "Nublado": "assets/images/nublado.png",
    "Despejado": "assets/images/cielo-despejado.png",
    "Lluvia moderada": "assets/images/lluvia-intensa.png",
    "Lluvia intensa": "assets/images/lluvia.png",
    "Granizo": "assets/images/granizo.png",
    "Tormenta": "assets/images/tormenta.png",
    "Neblina": "assets/images/neblina.png",
    "Viento": "assets/images/viento.png",
    "Nevada": "assets/images/nevada.png",
    "Ventisca": "assets/images/vientoClima.png",
    "Niebla": "assets/images/niebla.png",
    "Llovizna": "assets/images/lluvia moderada.png",
    "Fuertes lluvias": "assets/images/lluvia.png",
    "Lluvias torrenciales":
        "assets/images/lluvia-moderada-intensa con truenos.png",
    "Granizada": "assets/images/granizada.png",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.azulClaroWeather,
                size: 25,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.principal);
              },
            ),
            const Spacer(),
            Image.asset(
              'assets/images/small_logo.png',
              width: 40,
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: climaImagenes.length,
        itemBuilder: (context, index) {
          String clima = climaImagenes.keys.elementAt(index);
          String imagen = climaImagenes[clima]!;

          return Column(
            children: [
              ListTile(
                leading: Image.asset(imagen, width: 80, height: 80),
                title: Text(
                  clima,
                  style: const TextStyle(
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColors.azulClaroWeather,
                  ),
                ),
              ),
              const SizedBox(height: 10), 
            ],
          );
        },
      ),
    );
  }
}
