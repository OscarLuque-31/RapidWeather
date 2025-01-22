class Weather {
  final double temperatura;
  final double velocidadViento;
  final double visibilidad;
  final double uv;
  final double temperaturaMinima;
  final double temperaturaMaxima;

  // Constructor de la clase Weather
  Weather(
      {required this.temperatura,
      required this.velocidadViento,
      required this.visibilidad,
      required this.uv,
      required this.temperaturaMinima,
      required this.temperaturaMaxima});

  // Método factory para crear una instancia de Weather a partir de un Json 
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        temperatura: json['avgtemp_c'],
        velocidadViento: json['maxwind_kph'],
        visibilidad: json['avgvis_km'],
        uv: json['uv'],
        temperaturaMinima: json['mintemp_c'],
        temperaturaMaxima: json['maxtemp_c']);
  }
}
