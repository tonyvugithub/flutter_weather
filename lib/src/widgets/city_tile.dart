import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/model/city/cityModel.dart';

class CityTile extends StatelessWidget {
  final CityModel city;

  CityTile({this.city});

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(city.name),
        onTap: () {
          Navigator.pushNamed(context, '/${city.lat}&${city.lon}');
        },
      ),
    );
  }
}
