import 'package:flutter/material.dart';
import 'package:weather/src/bloc/weather_provider.dart';
import 'package:weather/src/model/weather/coord_model.dart';
import 'package:weather/src/screens/weather_details.dart';
import 'screens/landing_screen.dart';
import 'bloc/city_provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return WeatherProvider(
      child: CityProvider(
        child: MaterialApp(
          title: 'Fluttering Weather',
          onGenerateRoute: routes,
          /*  theme: ThemeData(
            textTheme: TextTheme(
              headline1: TextStyle(color: Colors.white),
              headline2: TextStyle(color: Colors.white70),
            ),
          ), */
        ),
      ),
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return LandingScreen();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final String currentRoute = settings.name;
          final delimIndex = currentRoute.indexOf('&');
          final lat = double.parse(currentRoute.substring(1, delimIndex));
          final lon = double.parse(currentRoute.substring(delimIndex + 1));
          final Coord coord = Coord(lat, lon);
          //Note: value of lat and lng successfully transfered to this route

          final weatherBloc = WeatherProvider.of(context);

          //Trigger the stream
          weatherBloc.fetchWeatherByCoord(coord);
          weatherBloc.fetchForecastByCoord(coord);

          return WeatherDetail(coord);
        },
      );
    }
  }
}
