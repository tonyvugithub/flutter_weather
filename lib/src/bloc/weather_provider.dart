import 'package:flutter/material.dart';

import 'weather_bloc.dart';
export 'weather_bloc.dart';

class WeatherProvider extends InheritedWidget {
  final bloc = WeatherBloc();

  WeatherProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static WeatherBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WeatherProvider>().bloc;
  }
}
