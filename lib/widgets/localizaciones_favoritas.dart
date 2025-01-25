import 'package:flutter/material.dart';
import 'package:rapid_weather/services/bbdd_service.dart';
import 'package:rapid_weather/utils/app_colors.dart';
import 'package:rapid_weather/views/localizaciones_favoritas_screen.dart';
import 'package:rapid_weather/widgets/localizacion_widget.dart';

class LocalizacionesFavoritas extends StatefulWidget {
  const LocalizacionesFavoritas({super.key});

  @override
  State<LocalizacionesFavoritas> createState() =>
      _LocalizacionesFavoritasState();
}

class _LocalizacionesFavoritasState extends State<LocalizacionesFavoritas> {
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final data = await DBHelper().fetchFavorites();
    setState(() {
      _favorites = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final limitedFavorites = _favorites.take(4).toList(); // Mostrar solo 4

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0), // Padding lateral
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Localizaciones Favoritas',
                style: TextStyle(
                  color: AppColors.azulClaroWeather,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const FavoritasScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Ver todas',
                  style: TextStyle(
                    color: AppColors.blancoWeather,
                    fontFamily: 'ReadexPro',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocalizacionWidget(ciudad: "Madrid", estadoClima: "Nublado", temperatura: 14),
              LocalizacionWidget(ciudad: "Barcelona", estadoClima: "Ligeras precipitaciones", temperatura: 17),
            ],
          ),
          const SizedBox(height: 16.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocalizacionWidget(ciudad: "Valencia", estadoClima: "Lluvia intensa", temperatura: 10),
              LocalizacionWidget(ciudad: "Sevilla", estadoClima: "Granizo", temperatura: 2),
            ],
          ),

          // ...limitedFavorites.map((favorite) => Padding(
          //       padding: const EdgeInsets.only(bottom: 8.0),
          //       child: Container(
          //         padding: const EdgeInsets.all(12.0),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(12.0),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Text(
          //               favorite['city_name'],
          //               style: const TextStyle(
          //                 color: AppColors.blancoWeather,
          //                 fontFamily: 'ReadexPro',
          //                 fontWeight: FontWeight.w400,
          //                 fontSize: 16,
          //               ),
          //             ),
          //             IconButton(
          //               icon: const Icon(
          //                 Icons.delete,
          //                 color: AppColors.azulClaroWeather,
          //               ),
          //               onPressed: () async {
          //                 await DBHelper().deleteFavorite(favorite['id']);
          //                 _loadFavorites();
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     )),
        ],
      ),
    );
  }
}
