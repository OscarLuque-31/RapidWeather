import 'package:flutter/material.dart';
import 'package:rapid_weather/views/bienvenida_screen.dart';
import 'package:rapid_weather/views/buscar_screen.dart';
import 'package:rapid_weather/views/clima_pronostico_ciudad_screen.dart';
import 'package:rapid_weather/views/datos_screen.dart';
import 'package:rapid_weather/views/principal_screen.dart';

class AppRoutes {
  // Definir nombres para las rutas como constantes
  static const String bienvenida = '/bienvenida';
  static const String principal = '/principal';
  static const String datos = '/datos';
  static const String buscarCiudad = "/buscarciudad";
  static const String climaPronosticoCiudad = "/climapronosticociudad";

  // Mapa de rutas
  static final Map<String, WidgetBuilder> routes = {
        
        principal: (context) => const PrincipalScreen(),
        datos: (context) => const DatosScreen(),
        bienvenida: (context) => const BienvenidaScreen(),
        buscarCiudad: (context) => const BuscarCiudadScreen(),
        climaPronosticoCiudad: (context) => const ClimaPronosticoCiudad(),
};
}
