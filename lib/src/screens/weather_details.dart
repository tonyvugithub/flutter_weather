import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/src/bloc/weather_provider.dart';
import 'package:weather/src/model/weather/weather_model.dart';
import 'package:weather_icons/weather_icons.dart';
import '../model/weather/coord_model.dart';
import '../model/weather/weather_forecast_model.dart';
import '../bloc/weather_bloc.dart';

class WeatherDetail extends StatelessWidget {
  final Coord _coord;

  WeatherDetail(Coord coord) : _coord = coord;

  Widget build(BuildContext context) {
    final bloc = WeatherProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather details',
          style: TextStyle(color: Colors.blue[900]),
        ),
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(
          color: Colors.blue[900], //change your color here
        ),
      ),
      body: _buildBody(bloc),
    );
  }

  Widget _buildBody(WeatherBloc bloc) {
    return Container(
      //Come back to this tmr
      child: ListView(
        children: <Widget>[
          _buildTitleTile(bloc),
          Divider(),
          _buildCurrentSnapshotTile(bloc),
          Divider(height: 25.0),
          _buildCurrentDetailsTile(bloc),
          Divider(height: 25.0),
          _buildForecastTile(bloc),
        ],
        //crossAxisAlignment: CrossAxisAlignment.start,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[900], Colors.blue]),
      ),
      padding: EdgeInsets.all(15.0),
    );
  }

  Widget _buildTileWithWeatherBloc(WeatherBloc bloc, Function buildFunc) {
    return StreamBuilder(
      stream: bloc.weatherStream,
      builder: (context, AsyncSnapshot<Future<WeatherModel>> snapshot) {
        if (!snapshot.hasData) {
          Text('loading');
        }

        return FutureBuilder(
          future: snapshot.data,
          builder: (context, AsyncSnapshot<WeatherModel> weatherSnapshot) {
            if (!weatherSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return buildFunc(weatherSnapshot.data);
          },
        );
      },
    );
  }

  Widget _buildTitleTile(WeatherBloc bloc) {
    return _buildTileWithWeatherBloc(bloc, _buildTitle);
  }

  Widget _buildCurrentSnapshotTile(WeatherBloc bloc) {
    return _buildTileWithWeatherBloc(bloc, _buildCurrentSnapshot);
  }

  Widget _buildCurrentDetailsTile(WeatherBloc bloc) {
    return _buildTileWithWeatherBloc(bloc, _buildCurrentDetails);
  }

  Widget _buildForecastTile(WeatherBloc bloc) {
    return StreamBuilder(
      stream: bloc.forecastStream,
      builder: (context,
          AsyncSnapshot<Future<List<WeatherForecastModel>>> snapshot) {
        if (!snapshot.hasData) {
          Text('loading');
        }

        return FutureBuilder(
          future: snapshot.data,
          builder: (context,
              AsyncSnapshot<List<WeatherForecastModel>> weatherSnapshot) {
            if (!weatherSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return _buildForecast(weatherSnapshot.data);
          },
        );
      },
    );
  }

  Widget _buildTitle(WeatherModel weather) {
    return Container(
      child: Text(
        '${weather.cityName}, ${weather.stateCode}, ${weather.countryCode}',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
    );
  }

  Widget _buildCurrentSnapshot(WeatherModel weather) {
    final appTemp = weather.appTemp.round();
    final temp = weather.temp.round();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.white,
      ),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  '$temp',
                  style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Text(' \u00b0 C',
                      style: TextStyle(color: Colors.grey[800])),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Feels like:', style: TextStyle(color: Colors.grey[800])),
                Row(
                  children: <Widget>[
                    Text('$appTemp\u00b0',
                        style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.end,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
        subtitle: Text('${weather.weather.description}',
            style: TextStyle(color: Colors.grey)),
        leading: _buildIcon(weather.weather.icon),
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }

  Widget _buildCurrentDetails(WeatherModel weather) {
    final children = [
      Row(
        children: <Widget>[Text('Sun rise'), Text('${weather.sunrise}')],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      Row(
        children: <Widget>[Text('Sun set'), Text('${weather.sunset}')],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      Row(
        children: <Widget>[Text('Wind speed'), Text('${weather.windSpeed}')],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      Row(
        children: <Widget>[Text('Wind direction'), Text('${weather.windDir}')],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      Row(
        children: <Widget>[Text('Pressure'), Text('${weather.pressure}')],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      Row(
        children: <Widget>[Text('Humidity'), Text('${weather.humidity}')],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      Row(
        children: <Widget>[Text('Air Quality'), Text('${weather.airQuality}')],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.white,
      ),
      child: ListView(
        children: children,
        shrinkWrap: true,
      ),
    );
  }

  Widget _buildForecast(List<WeatherForecastModel> forecastList) {
    return Container(
      height: 170.0,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              '16-day Forcast:',
              style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
            padding: EdgeInsets.only(left: 10.0, top: 5.0),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: forecastList.length,
              itemBuilder: (BuildContext context, int index) {
                final forecast = forecastList[index];
                return _buildForecastCard(forecast);
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  Widget _buildForecastCard(WeatherForecastModel forecast) {
    final dateFormat = new DateFormat.E().format;
    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(
              '${dateFormat(forecast.date)}, ${forecast.date.day}',
              style: TextStyle(color: Colors.grey[800], fontSize: 15.0),
            ),
            Divider(
              height: 5.0,
            ),
            Text(
              'High: ${forecast.highTemp.round()}\u00b0',
              style: TextStyle(color: Colors.grey[500], fontSize: 12.0),
            ),
            Text(
              'Low: ${forecast.lowTemp.round()}\u00b0',
              style: TextStyle(color: Colors.grey[500], fontSize: 12.0),
            ),
            Row(
              children: <Widget>[
                Container(
                  child: Icon(
                    WeatherIcons.rain_mix,
                    color: Colors.blue[900],
                    size: 10.0,
                  ),
                  padding: EdgeInsets.only(right: 7.0, bottom: 5.0),
                ),
                Text(
                  '${forecast.pop}%',
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                ),
              ],
            ),
            Divider(
              height: 5.0,
            ),
            Container(
              height: 40.0,
              child: _buildIcon(forecast.weather.icon),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      ),
      margin: EdgeInsets.all(10.0),
      elevation: 10.0,
    );
  }

  Widget _buildIcon(String iconCode) {
    return Image.network(
      'https://www.weatherbit.io/static/img/icons/${iconCode}.png',
    );
  }

  Coord get coord => _coord;
}
