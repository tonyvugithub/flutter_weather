import 'package:http/http.dart' show Client;
import 'package:weather/src/model/weather/weather_forecast_model.dart';
import '../model/weather/weather_model.dart';
import 'dart:async';
import 'dart:convert';

import '../model/weather/coord_model.dart';

final _apiKey = '54211b6f514344a5b47e55b6debaee0b';
final _rootUrl = 'http://api.weatherbit.io/v2.0';

class WeatherApiProvider {
  final Client client = Client();

  Future<WeatherModel> fetchWeather(Coord coord) async {
    final response = await client.get(
        '$_rootUrl/current?lat=${coord.lat}&lon=${coord.lon}&key=$_apiKey');

    final parsedJson = jsonDecode(response.body);

    return WeatherModel.fromJson(parsedJson['data'][0]);
  }

  Future<List<WeatherForecastModel>> fetchForecast(Coord coord) async {
    final response = await client.get(
        '$_rootUrl/forecast/daily?lat=${coord.lat}&lon=${coord.lon}&key=$_apiKey');
    final forecasts = jsonDecode(response.body)['data'];

    List<WeatherForecastModel> forecastList = [];

    for (var forecast in forecasts) {
      forecastList.add(WeatherForecastModel.fromJson(forecast));
    }

    return forecastList;
  }
}
