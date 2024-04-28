class WeatherUIModel {
  final double? latitude;
  final double? longitude;
  final String? timezone;
  final int? timezoneOffset;
  final String? currentTemperature;
  final String? currentWeatherDescription;
  final String? currentWeatherIcon;
  final List<DailyUIModel>? dailyForecasts;

  WeatherUIModel({
    this.latitude,
    this.longitude,
    this.timezone,
    this.timezoneOffset,
    this.currentTemperature,
    this.currentWeatherDescription,
    this.currentWeatherIcon,
    this.dailyForecasts,
  });
}

class DailyUIModel {
  final DateTime? date;
  final String? day;

  final double? dayTemperature;
  final String? weatherDescription;
  final String? weatherIcon;

  DailyUIModel({
    this.date,
    this.day,
    this.dayTemperature,
    this.weatherDescription,
    this.weatherIcon,
  });
}
