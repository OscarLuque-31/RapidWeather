import 'package:rapid_weather/models/forecast_day.dart';

class Forecast {
  final List<ForecastDay> forecastday;

  Forecast({
    required this.forecastday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var forecastdayList = json['forecastday'];
    List<ForecastDay> forecastDays = [];

    if (forecastdayList != null && forecastdayList is List) {
      forecastDays =
          forecastdayList.map((i) => ForecastDay.fromJson(i)).toList();
    }

    return Forecast(forecastday: forecastDays);
  }
}
