import 'package:weather/src/model/weather/coord_model.dart';
import 'package:weather/src/model/weather/weather_forecast_model.dart';

import '../model/weather/weather_model.dart';
import '../model/city/cityModel.dart';
import 'city_api_provider.dart';
import '../model/weather/weather_model.dart';
import 'weather_api_provider.dart';

class Repository {
  CityApiProvider cityClient = CityApiProvider();
  WeatherApiProvider weatherClient = WeatherApiProvider();

  Future<List<CityModel>> fetchCityList(String cityName) =>
      cityClient.fetchCityList(cityName);

  Future<WeatherModel> fetchWeather(Coord coord) =>
      weatherClient.fetchWeather(coord);

  Future<List<WeatherForecastModel>> fetchForecast(Coord coord) =>
      weatherClient.fetchForecast(coord);
}
