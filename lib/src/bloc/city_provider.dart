import 'package:flutter/material.dart';

import 'city_bloc.dart';
export 'city_bloc.dart';

class CityProvider extends InheritedWidget {
  final bloc = CityBloc();

  CityProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static CityBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CityProvider>().bloc;
  }
}
