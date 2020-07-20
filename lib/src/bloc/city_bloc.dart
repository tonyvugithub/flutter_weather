import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:weather/src/resources/repository.dart';
import '../model/city/cityModel.dart';

class CityBloc {
  final _repository = Repository();

  final _cityInput = BehaviorSubject<String>();
  final _cityList = BehaviorSubject<String>();

  //Sink getters
  Function(String) get changeCityInput => _cityInput.add;
  Function(String) get changeCityList => _cityList.add;

  //Stream getters
  Stream<String> get cityStream => _cityInput.stream;
  Stream<Future<List<CityModel>>> get cityListStream =>
      _cityList.stream.transform(_cityListTransformer());

  //Note: You can call API inside of the transformer;
  _cityListTransformer() {
    return StreamTransformer<String, Future<List<CityModel>>>.fromHandlers(
        handleData: (cityName, sink) {
      final cityListFuture = _repository.fetchCityList(cityName);
      sink.add(cityListFuture);
    });
  }

  //Dispose function
  void dispose() {
    _cityInput.close();
    _cityList.close();
  }
}
