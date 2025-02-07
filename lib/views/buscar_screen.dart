import 'package:flutter/material.dart';
import 'package:rapid_weather/models/location.dart';
import 'package:rapid_weather/routes/routes.dart';
import 'package:rapid_weather/services/bbdd_service.dart';
import 'package:rapid_weather/services/api_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/widgets/barra_buscar.dart';
import 'package:rapid_weather/widgets/localizacion_buscada_widget.dart';

class BuscarCiudadScreen extends StatefulWidget {
  const BuscarCiudadScreen({super.key});

  @override
  State<BuscarCiudadScreen> createState() => _BuscarCiudadScreenState();
}

class _BuscarCiudadScreenState extends State<BuscarCiudadScreen> {
  // Lista donde se almacenan las ciudades encontradas en la búsqueda
  List<Location> locations = [];

  // Indica si la búsqueda está en curso (para mostrar un indicador de carga)
  bool isLoading = false;

  // Lista de búsquedas recientes almacenadas en la base de datos
  List<String> recentSearches = [];

  // Mensaje de error en caso de que ocurra un problema durante la búsqueda
  String errorMessage = '';

  // Indica si se ha realizado una búsqueda
  bool isSearched = false;

  // Controla si se deben mostrar las búsquedas recientes en la interfaz
  bool showRecentSearches = true;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  // Carga las últimas 5 búsquedas recientes desde la base de datos
  Future<void> _loadRecentSearches() async {
    final searches = await DBService().fetchRecentSearches(limit: 5);
    setState(() {
      recentSearches = searches;
    });
  }

  // Busca ciudades en la API según la consulta del usuario
  Future<void> _buscarCiudades(String query) async {
    if (query.isEmpty) {
      setState(() {
        locations = [];
        errorMessage = 'Por favor, ingresa una ciudad para buscar';
        isSearched = false;
      });
      return;
    }

    // Activa el indicador de carga y oculta las búsquedas recientes
    setState(() {
      isLoading = true;
      errorMessage = '';
      isSearched = true;
      showRecentSearches = false;
    });

    try {
      // Llamada a la API para obtener las ciudades según la consulta
      final results = await ApiService().fetchLocations(query);
      setState(() {
        locations = results.cast<Location>();
        isLoading = false;
      });
      // Guarda la búsqueda en la base de datos para futuras referencias
      await DBService().insertRecentSearch(query);
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error al buscar ciudades: $e';
      });
    }
  }

  // Elimina todas las búsquedas recientes de la base de datos
  Future<void> _clearRecentSearches() async {
    await DBService().clearRecentSearches();
    // Recarga la lista de búsquedas recientes
    _loadRecentSearches();
  }

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            BarraBuscar(
              onSearch: _buscarCiudades,
            ),

            /// Búsquedas recientes con mejor estilo
            if (showRecentSearches && recentSearches.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Búsquedas recientes:',
                      style: TextStyle(
                        fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.w700,
                        color: AppColors.azulClaroWeather,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: _clearRecentSearches,
                      child: const Text(
                        'Limpiar',
                        style: TextStyle(
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.w700,
                          color: AppColors.blancoWeather,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: recentSearches.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5),
                      child: Card(
                        color: AppColors.azulGrisaceoWeather,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            recentSearches[index],
                            style: const TextStyle(
                              color: AppColors.blancoWeather,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.search,
                            color: AppColors.azulClaroWeather,
                          ),
                          onTap: () => _buscarCiudades(recentSearches[index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            if (isLoading) ...[
              const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.azulClaroWeather,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.azulGrisaceoWeather),
                ),
              ),
            ] else if (errorMessage.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Readex Pro',
                    color: AppColors.azulClaroWeather,
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
                    fontFamily: 'Readex Pro',
                    fontSize: 16,
                    color: AppColors.azulClaroWeather,
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
