class WeatherModel {
  WeatherModel({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.hourly,
    required this.current,
  });

  num latitude;
  num longitude;
  String timezone;
  Hourly hourly;
  Current current;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        timezone: json["timezone"],
        hourly: Hourly.fromJson(json["hourly"]),
        current: Current.fromJson(json["current"]),
      );
}

class Hourly {
  Hourly({
    required this.temperature,
    required this.weatherCode,
  });
  List<double> temperature;
  List<int> weatherCode;

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        temperature:
            List<double>.from(json["temperature_2m"].map((e) => e.toDouble())),
        weatherCode: List<int>.from(json["weather_code"].map((e) => e.toInt())),
      );
}

class Current {
  Current({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.precipitaion,
    required this.weatherCode,
  });

  num temperature;
  num windSpeed;
  num humidity;
  num precipitaion;
  int weatherCode;

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        temperature: json["temperature_2m"].toDouble(),
        windSpeed: json["wind_speed_10m"].toDouble(),
        humidity: json["relative_humidity_2m"].toInt(),
        precipitaion: json["precipitation_probability"].toInt(),
        weatherCode: json["weather_code"].toInt(),
      );
}
