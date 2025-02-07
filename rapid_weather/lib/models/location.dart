/// Clase Location que representa la localización de donde se obtiene el clima
class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String nameRegion;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.nameRegion,
    required this.localtime,
  });

  // Método para transformar el JSON a un objeto Location y lo retorna
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      country: json['country'] ?? '',
      lat: json['lat']?.toDouble() ?? 0.0,
      lon: json['lon']?.toDouble() ?? 0.0,
      nameRegion: json['tz_id'] ?? '',
      localtime: json['localtime'] ?? '',
    );
  }

  // Método para convertir una lista dinámica en una lista de objetos Location
  static List<Location> listFromJson(List<dynamic> list) {
    return list.map((item) => Location.fromJson(item)).toList();
  }


}