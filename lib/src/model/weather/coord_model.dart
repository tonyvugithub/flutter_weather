class Coord {
  double _lat;
  double _lon;

  Coord(double lat, double lon)
      : _lat = lat,
        _lon = lon;

  Coord.fromJson(parsedJson) {
    _lat = parsedJson['lat'];
    _lon = parsedJson['lon'];
  }

  double get lat => _lat;
  double get lon => _lon;
}
