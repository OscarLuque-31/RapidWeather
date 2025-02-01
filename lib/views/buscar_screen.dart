import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/services/api_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/widgets/barra_buscar.dart';
import 'package:rapid_weather/widgets/localizacion_buscada_widget.dart'; // Asegúrate de importar fetchLocations

class BuscarCiudadScreen extends StatefulWidget {
  const BuscarCiudadScreen({super.key});

  @override
  State<BuscarCiudadScreen> createState() => _BuscarCiudadScreenState();
}

class _BuscarCiudadScreenState extends State<BuscarCiudadScreen> {
  List<Location> locations = []; // Lista de resultados
  bool isLoading = false; // Mostrar indicador de carga
  String errorMessage = ''; // Mensaje de error si falla la búsqueda
  bool isSearched =
      false; // Bandera para controlar si ya se realizó una búsqueda

  // Método para buscar ciudades
  Future<void> _buscarCiudades(String query) async {
    if (query.isEmpty) {
      setState(() {
        locations = [];
        errorMessage = 'Por favor, ingresa una ciudad para buscar';
        isSearched = false; // No se ha realizado ninguna búsqueda válida
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
      isSearched = true; // Se marca que ya se realizó una búsqueda
    });

    try {
      final results =
          await ApiService().fetchLocations(query); // Llamada a la API
      setState(() {
        locations = results.cast<Location>();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error al buscar ciudades: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.azulClaroWeather,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.principal);
                  },
                );
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Barra de búsqueda
            BarraBuscar(
              onSearch: _buscarCiudades,
            ),
            if (isLoading) ...[
              const Center(
                  child: CircularProgressIndicator(
                backgroundColor: AppColors.azulClaroWeather,
                valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.azulGrisaceoWeather),
              )),
            ] else if (errorMessage.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.azulClaroWeather,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ] else if (isSearched && locations.isEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No se encontraron resultados',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.azulClaroWeather,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final location = locations[index];
                    return LocalizacionBuscadaWidget(location: location);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      backgroundColor: AppColors.azulOscuroWeather,
    );
  }
}
