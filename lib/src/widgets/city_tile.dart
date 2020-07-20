import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/src/model/city/cityModel.dart';

class CityTile extends StatelessWidget {
  final CityModel city;

  CityTile({this.city});

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          city.name,
          style: TextStyle(fontSize: 15.0),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/${city.lat}&${city.lon}');
        },
        dense: true,
      ),
    );
  }
}
