import 'package:weather/model/weather_model.dart';
import 'package:weather/service/network_service.dart';

class WeatherController {
  static Future getWeather(double lat, double long) async {
    String url = "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&hourly=temperature_2m,weather_code&current=precipitation_probability,temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m&timezone=auto";
    NetworkService networkService = NetworkService(url: url);
    try {
      var data = await networkService.getData();
      WeatherModel weatherModel = WeatherModel.fromJson(data);
      return weatherModel;
    } catch (e) {
      rethrow;
    }
  }
}
