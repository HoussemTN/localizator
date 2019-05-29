import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MyLocationView.dart';

import 'package:localizer/Widgets/Weather.dart';
import 'package:localizer/Widgets/WeatherItem.dart';


import 'package:localizer/models/WeatherData.dart';
import 'package:localizer/models/ForecastData.dart';



class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;

  double lat=MyLocationViewState.lat;
  double long=MyLocationViewState.long ;


  @override
  void initState() {
    super.initState();

   loadWeather();
   }



  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: weatherData != null ? Weather(weather: weatherData) : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading ? CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: new AlwaysStoppedAnimation(Colors.white),
                      ) : IconButton(
                        icon: new Icon(Icons.refresh),
                        tooltip: 'Refresh',
                        onPressed: loadWeather,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200.0,
                    child: forecastData != null ? ListView.builder(
                        itemCount: forecastData.list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => WeatherItem(weather: forecastData.list.elementAt(index))
                    ) : Container(),
                  ),
                ),
              )
            ]
        ),
        );
  }
  loadWeather() async {
    setState(() {

      isLoading = true;
    });

  final weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?APPID=e438793d26f931f5c2d283df4f520108&lat=${lat
            .toString()}&lon=${long.toString()}&units=metric');
   final forecastResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?units=metric&APPID=e438793d26f931f5c2d283df4f520108&lat=${lat
            .toString()}&lon=${long.toString()}&units=metric');

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData = new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }

    setState(() {

      isLoading = false;
    });
  }
}

