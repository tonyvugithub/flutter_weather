import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';
import '../resources/city_api_provider.dart';
import '../bloc/city_provider.dart';
import '../model/city/cityModel.dart';
import '../widgets/city_tile.dart';

class LandingScreen extends StatelessWidget {
  final cityClient = CityApiProvider();

  Widget build(BuildContext context) {
    final bloc = CityProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fluttering Weather',
          style: TextStyle(color: Colors.blue[900]),
        ),
        backgroundColor: Colors.yellow,
        elevation: 4,
      ),
      body: _buildBody(context, bloc),
    );
  }

  Widget _buildBody(BuildContext context, CityBloc bloc) {
    final child = Column(
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Icon(WeatherIcons.day_sunny, color: Colors.yellow[600]),
              Container(width: 15.0),
              Icon(WeatherIcons.cloudy, color: Colors.blue[200]),
              Container(width: 15.0),
              Icon(WeatherIcons.snowflake_cold, color: Colors.white70),
              Container(width: 15.0),
              Icon(WeatherIcons.raindrops, color: Colors.blueGrey[100]),
              Container(width: 15.0),
              Icon(WeatherIcons.strong_wind, color: Colors.teal[300]),
              Container(width: 15.0),
              Icon(WeatherIcons.thunderstorm, color: Colors.yellow[300]),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          padding: EdgeInsets.only(bottom: 35.0),
        ),
        _buildForm(context, bloc),
        Container(
          child: Text('Or', style: TextStyle(color: Colors.yellow)),
          padding: EdgeInsets.symmetric(vertical: 5.0),
        ),
        RaisedButton(
          child: Text(
            'Use Current Location',
            style: TextStyle(color: Colors.blue[900]),
          ),
          onPressed: () async {
            Position position = await Geolocator()
                .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
            Navigator.pushNamed(
                context, '/${position.latitude}&${position.longitude}');
          },
          color: Colors.yellow[200],
        ),
        Divider(
          height: 30.0,
          color: Colors.yellow,
        ),
        Expanded(
          child: _buildCityList(bloc),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    return Container(
      child: child,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[900], Colors.blue]),
      ),
    );
  }

  Widget _buildCityList(CityBloc bloc) {
    return StreamBuilder(
      stream: bloc.cityListStream,
      builder: (context, AsyncSnapshot<Future<List<CityModel>>> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }

        if (!snapshot.hasData) {
          return Text(
            'No city has been entered!',
            style: TextStyle(color: Colors.yellow[200]),
          );
        }

        return FutureBuilder(
          future: snapshot.data,
          builder: (context, AsyncSnapshot<List<CityModel>> citySnapshot) {
            if (!citySnapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            if (citySnapshot.data.length == 0) {
              return Text(
                'Check your typing, there might be some typo',
                style: TextStyle(color: Colors.orange[300]),
              );
            }

            final children = <Widget>[];
            final cityList = citySnapshot.data.map((item) {
              return CityTile(city: item);
            });
            children.addAll(cityList);
            return Column(
              children: <Widget>[
                Text(
                  'We found ${citySnapshot.data.length} results, which one is your city?',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.yellow[200],
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView(
                    children: children,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            );
          },
        );
      },
    );
  }

  Widget _buildForm(BuildContext context, CityBloc bloc) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              'Enter your city',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.yellow,
              ),
            ),
            padding: EdgeInsets.only(bottom: 10.0),
          ),
          Row(
            children: <Widget>[
              _buildSearchField(context, bloc),
              _buildSearchButton(bloc),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, CityBloc bloc) {
    return Container(
      width: MediaQuery.of(context).size.width - 90.0,
      child: TextField(
        style: TextStyle(color: Colors.blue[900]),
        decoration: InputDecoration(
          hintText: 'Eg: Toronto',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(10.0),
          filled: true,
          fillColor: Colors.white,
        ),
        cursorColor: Colors.blue,
        onChanged: bloc.changeCityInput,
      ),
    );
  }

  Widget _buildSearchButton(CityBloc bloc) {
    return StreamBuilder(
      stream: bloc.cityStream,
      builder: (context, snapshot) {
        return Container(
          child: IconButton(
            onPressed: () {
              bloc.changeCityList(snapshot.data);
            },
            icon: Icon(Icons.search, size: 30),
            padding: EdgeInsets.zero,
            color: Colors.white,
          ),
        );
      },
    );
  }
}
