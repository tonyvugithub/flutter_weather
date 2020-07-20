import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:weather/src/model/weather/weather_forecast_model.dart';
import '../resources/repository.dart';
import '../model/weather/weather_model.dart';
import '../model/weather/coord_model.dart';

class WeatherBloc {
  final _repository = Repository();

  //Subjects/Controllers
  final _weather = BehaviorSubject<Coord>();
  final _weatherForcast = BehaviorSubject<Coord>();

  //Sink getters
  Function(Coord) get fetchWeatherByCoord => _weather.add;

  Function(Coord) get fetchForecastByCoord => _weatherForcast.add;

  //Stream getters
  Stream<Future<WeatherModel>> get weatherStream =>
      _weather.stream.transform(_weatherTransformer());

  Stream<Future<List<WeatherForecastModel>>> get forecastStream =>
      _weatherForcast.stream.transform(_forecastTransformer());

  //Transformers
  _weatherTransformer() {
    return StreamTransformer<Coord, Future<WeatherModel>>.fromHandlers(
      handleData: (coord, sink) {
        sink.add(_repository.fetchWeather(coord));
      },
    );
  }

  _forecastTransformer() {
    return StreamTransformer<Coord,
        Future<List<WeatherForecastModel>>>.fromHandlers(
      handleData: (coord, sink) {
        sink.add(_repository.fetchForecast(coord));
      },
    );
  }

  //Dispose function
  void dispose() {
    _weather.close();
    _weatherForcast.close();
  }
}
