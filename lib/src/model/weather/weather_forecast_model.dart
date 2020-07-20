import 'package:weather/src/model/weather/weather_item_model.dart';

import 'weather_item_model.dart';

class WeatherForecastModel {
  num _highTemp;
  num _lowTemp;
  WeatherItem _weather;
  DateTime _date;
  num _pop;

  WeatherForecastModel.fromJson(parsedJson) {
    _highTemp = parsedJson['high_temp'];
    _lowTemp = parsedJson['low_temp'];
    _weather = WeatherItem.fromJson(parsedJson['weather']);
    _date = DateTime.parse(parsedJson['valid_date']);
    _pop = parsedJson['pop'];
    print('Finished creating forecast object');
  }

  num get highTemp => _highTemp;
  num get lowTemp => _lowTemp;
  WeatherItem get weather => _weather;
  DateTime get date => _date;
  num get pop => _pop;
}
