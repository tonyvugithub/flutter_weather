class WeatherItem {
  String _icon;
  String _description;
  String _code;

  WeatherItem.fromJson(parsedJson) {
    _icon = parsedJson['icon'].toString();
    _description = parsedJson['description'].toString();
    _code = parsedJson['code'].toString();
  }

  String get icon => _icon;
  String get description => _description;
  String get code => _code;
}
