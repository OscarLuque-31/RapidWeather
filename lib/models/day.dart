import 'package:rapid_weather/models/condition.dart';

/// Clase Day que representa un día
class Day {
  final double maxtempC;
  final double mintempC;
  final double avgtempC;
  final double maxwindKph;
  final double totalprecipMm;
  final double avgvisKm;
  final int avghumidity;
  final int dailyChanceOfRain;
  final int dailyChanceOfSnow;
  final Condition condition;
  final double uv;

  Day({
    required this.maxtempC,
    required this.mintempC,
    required this.avgtempC,
    required this.maxwindKph,
    required this.totalprecipMm,
    required this.avgvisKm,
    required this.avghumidity,
    required this.dailyChanceOfRain,
    required this.dailyChanceOfSnow,
    required this.condition,
    required this.uv,
  });

  // Método para transformar el JSON a un objeto Day y lo retorna
  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxtempC: json['maxtemp_c']?.toDouble() ?? 0.0,
      mintempC: json['mintemp_c']?.toDouble() ?? 0.0,
      avgtempC: json['avgtemp_c']?.toDouble() ?? 0.0,
      maxwindKph: json['maxwind_kph']?.toDouble() ?? 0.0,
      totalprecipMm: json['totalprecip_mm']?.toDouble() ?? 0.0,
      avgvisKm: json['avgvis_km']?.toDouble() ?? 0.0,
      avghumidity: json['avghumidity'] ?? 0,
      dailyChanceOfRain: json['daily_chance_of_rain'] ?? 0,
      dailyChanceOfSnow: json['daily_chance_of_snow'] ?? 0,
      condition: Condition.fromJson(json['condition'] ?? {}),
      uv: json['uv']?.toDouble() ?? 0.0,
    );
  }
}