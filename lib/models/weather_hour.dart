class WeatherHour {
  final int hora; // Hora (0-23)
  final double temperatura; // Temperatura a esa hora
  final double velocidadViento; // Velocidad del viento
  final double humedad; // Humedad
  final double visibilidad; // Visibilidad
  final double uv; // Índice UV
  final String estadoClima; // Estado del clima

  WeatherHour({
    required this.hora,
    required this.temperatura,
    required this.velocidadViento,
    required this.humedad,
    required this.visibilidad,
    required this.uv,
    required this.estadoClima,
  });

  // Método para crear una instancia de WeatherHour a partir de un JSON
  factory WeatherHour.fromJson(Map<String, dynamic> json) {
    return WeatherHour(
      hora: int.parse(json['time'].split(' ')[1].split(':')[0]), // Hora extraída del campo 'time'
      temperatura: json['temp_c']?.toDouble() ?? 0.0,
      velocidadViento: json['wind_kph']?.toDouble() ?? 0.0,
      humedad: json['humidity']?.toDouble() ?? 0.0,
      visibilidad: json['vis_km']?.toDouble() ?? 0.0,
      uv: json['uv']?.toDouble() ?? 0.0,
      estadoClima: json['condition']?['text'] ?? 'Desconocido',
    );
  }
}
