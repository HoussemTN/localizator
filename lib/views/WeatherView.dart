import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../libraries/secrets.dart' as secrets;
import '../libraries/globals.dart' as globals;
import 'package:localizer/Widgets/Weather.dart';
import 'package:localizer/Widgets/WeatherForecastItem.dart';

import 'package:localizer/models/WeatherData.dart';
import 'package:localizer/models/ForecastData.dart';
import 'package:geolocator/geolocator.dart';

class WeatherView extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<WeatherView> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  double lat = globals.lat;
  double long = globals.long;
  var forecastResponse=globals.forecastResponse;
  var weatherResponse=globals.weatherResponse;
  /// DEFAULT [FALSE] to call the weather API at least one time
  bool isWeatherUpToDate=false;
 /// checks WeatherData I fit needs to be updated or not
  /// return [bool}
  bool weatherUpToDate(DateTime lastUpdateDateTime){
    print('last:$lastUpdateDateTime');
    var now = new DateTime.now().toUtc();
    print('now :$now');
    /// Difference between two DatTime the current and the lastUpdated Weather
    var diff =now.difference(lastUpdateDateTime);
    print('diff:${diff.inMinutes}');
    /// Update WeatherData after 15 minutes
    if(diff.inMinutes > 15){
      return false;
    }else{
      return true;
    }

  }
  callWeather() async {
    /// Handle loader
    loadWeather();
    isWeatherUpToDate=weatherUpToDate(globals.lastWeatherUpdateDateTime);

    print(isWeatherUpToDate);
    if (globals.weatherResponse==null|| isWeatherUpToDate==false) {

      weatherResponse = await http.get(
          "https://api.openweathermap.org/data/2.5/weather?APPID=${secrets.APP_ID}&lat=${lat
              .toString( )}&lon=${long.toString( )}" );
      globals.weatherResponse=weatherResponse;
      ///last Update Time;
    globals.lastWeatherUpdateDateTime=DateTime.now().toUtc();
    }
    if(globals.forecastResponse==null||isWeatherUpToDate==false) {
       forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=${secrets.APP_ID}&lat=${lat
              .toString( )}&lon=${long.toString( )}&lang=eng' );
       globals.forecastResponse=forecastResponse;

    }
    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData =
            new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData =
            new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }else{
      /// Get Date From Local without calling the weather API
      return setState(() {
        weatherData =
        new WeatherData.fromJson(jsonDecode(globals.weatherResponse.body));
        forecastData =
        new ForecastData.fromJson(jsonDecode(globals.forecastResponse.body));
        isLoading = false;
      });
    }

/*    setState(() {
       print(isLoading.toString());
       isLoading = false;
    });*/
  }
 getCurrentPosition()async{
   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   return position;
  }
  @override
  void initState() {
    super.initState();
    print(lat);
    print(long);
    if(lat==null && long==null){
      Position position = getCurrentPosition();
      lat =position.latitude;
      long =position.longitude ;
      print(lat);
      print(long);
    }
    callWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView(children: <Widget>[
        Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(

              child: weatherData != null
                  ? Weather(weather: weatherData)
                  : Container(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top:10.0,left: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 0.8,
                height: 200,
                child: forecastData != null
                    ? ListView.builder(
                        itemCount: forecastData.list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => WeatherItem(
                            weather: forecastData.list.elementAt(index)))
                    : Container(),
              ),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            isLoading
                ? Column(
                    children: <Widget>[
                      Text("Searching.."),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          strokeWidth: 4.0,
                          valueColor: new AlwaysStoppedAnimation(Colors.teal),
                        ),
                      ),
                    ],
                  )
                : Container() /*IconButton(
                icon: new Icon(Icons.refresh),
                tooltip: 'Refresh',
                onPressed: loadWeather,
                color: Colors.red,
              ),*/
          ],
        )
      ]),

    );
  }

  loadWeather() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
  }

}
