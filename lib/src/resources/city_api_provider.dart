import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:weather/src/model/city/cityModel.dart';

final _apiKey = 'eee701711ff5410393b8f1cb748b0c2f';

class CityApiProvider {
  Client client = Client();

  Future<List<CityModel>> fetchCityList(String cityName) async {
    List<CityModel> cityList = [];
    final response = await client.get(
        'https://api.opencagedata.com/geocode/v1/json?q=$cityName&key=$_apiKey');
    final results = jsonDecode(response.body)['results'];

    for (var result in results) {
      if (result['formatted']
          .contains(new RegExp(cityName, caseSensitive: false))) {
        cityList.add(CityModel(
          name: result['formatted'],
          lat: result['geometry']['lat'],
          lon: result['geometry']['lng'],
        ));
      }
    }
    return cityList;
  }
}
