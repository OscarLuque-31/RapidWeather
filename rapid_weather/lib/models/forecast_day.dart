import 'package:rapid_weather/models/day.dart';
import 'package:rapid_weather/models/hour.dart';

/// Clase ForecastDay que representa el pronostico por horas del día
class ForecastDay {
  final String date;
  final Day day;
  final List<Hour> hour;

  ForecastDay({
    required this.date,
    required this.day,
    required this.hour,
  });

  // Método para transformar el JSON a un objeto ForecastDay y lo retorna
  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    var hourList = json['hour'] as List;
    List<Hour> hours = hourList.map((i) => Hour.fromJson(i)).toList();
    return ForecastDay(
      date: json['date'] ?? '',
      day: Day.fromJson(json['day'] ?? {}),
      hour: hours,
    );
  }
}