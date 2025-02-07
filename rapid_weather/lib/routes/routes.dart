import 'package:flutter/material.dart';
import 'package:rapid_weather/views/atribuciones_screen.dart';
import 'package:rapid_weather/views/bienvenida_screen.dart';
import 'package:rapid_weather/views/buscar_screen.dart';
import 'package:rapid_weather/views/clima_pronostico_ciudad_screen.dart';
import 'package:rapid_weather/views/clima_pronostico_dias_ciudad_screen.dart';
import 'package:rapid_weather/views/condiciones_clima.dart';
import 'package:rapid_weather/views/datos_screen.dart';
import 'package:rapid_weather/views/principal_screen.dart';

/// Clase AppRoutes que contiene todas las rutas de navegación
class AppRoutes {
  // Nombre constantes definidos para la ruta de navegación
  static const String bienvenida = '/bienvenida';
  static const String principal = '/principal';
  static const String datos = '/datos';
  static const String buscarCiudad = "/buscarciudad";
  static const String climaPronosticoCiudad = "/climapronosticociudad";
  static const String climaPronosticoDiasCiudad = "/climapronosticodiasciudad";
  static const String condicionesClima = "/condicionesClima";
  static const String atribuciones = "/atribuciones";

  // Mapa con las rutas que se usan para navegar
  static final Map<String, WidgetBuilder> routes = { 
        principal: (context) => const PrincipalScreen(),
        datos: (context) => const DatosScreen(),
        bienvenida: (context) => const BienvenidaScreen(),
        buscarCiudad: (context) => const BuscarCiudadScreen(),
        climaPronosticoCiudad: (context) => const ClimaPronosticoCiudad(),
        climaPronosticoDiasCiudad: (context) => const ClimaPronosticoDiasCiudad(),
        condicionesClima: (context) => const CondicionesClimaScreen(),
        atribuciones: (context) => const AtribucionesScreen()
};
}
