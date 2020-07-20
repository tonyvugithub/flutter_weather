import 'weather_item_model.dart';

class WeatherModel {
  String _cityName;
  String _stateCode;
  String _countryCode;
  num _windSpeed;
  String _windDir;
  num _temp;
  num _appTemp;
  String _sunrise;
  String _sunset;
  num _pressure;
  num _humidity;
  num _airQuality;
  WeatherItem _weather;

  WeatherModel.fromJson(Map<String, dynamic> parsedJson) {
    _cityName = parsedJson['city_name'].toString();
    _stateCode = parsedJson['state_code'].toString();
    _countryCode = parsedJson['country_code'].toString();
    _windSpeed = parsedJson['wind_spd'];
    _windDir = parsedJson['wind_cdir'].toString();
    _temp = parsedJson['temp'];
    _appTemp = parsedJson['app_temp'];
    _sunrise = parsedJson['sunrise'].toString();
    _sunset = parsedJson['sunset'].toString();
    _pressure = parsedJson['pres'];
    _humidity = parsedJson['rh'];
    _airQuality = parsedJson['aqi'];
    _weather = WeatherItem.fromJson(parsedJson['weather']);
  }

  String get cityName => _cityName;
  String get stateCode => _stateCode;
  String get countryCode => _countryCode;
  num get windSpeed => _windSpeed;
  String get windDir => _windDir;
  num get temp => _temp;
  num get appTemp => _appTemp;
  String get sunrise => _sunrise;
  String get sunset => _sunset;
  num get pressure => _pressure;
  num get humidity => _humidity;
  num get airQuality => _airQuality;
  WeatherItem get weather => _weather;
}
