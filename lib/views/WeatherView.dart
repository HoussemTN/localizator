import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../libraries/globals.dart' as globals;
import 'package:localizer/Widgets/Weather.dart';
import 'package:localizer/Widgets/WeatherItem.dart';

import 'package:localizer/models/WeatherData.dart';
import 'package:localizer/models/ForecastData.dart';

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

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
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
       Column(
         children: <Widget>[
           Container(
             width:MediaQuery.of(context).size.width/0.8 ,
             height: MediaQuery.of(context).size.height/3,
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
    setState(() {
      isLoading = true;
    });

    final weatherResponse = await http.get(
        "https://api.openweathermap.org/data/2.5/weather?APPID=e438793d26f931f5c2d283df4f520108&lat=${lat.toString()}&lon=${long.toString()}");
    final forecastResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?units=metric&APPID=e438793d26f931f5c2d283df4f520108&lat=${lat.toString()}&lon=${long.toString()}&units=metric&lang=eng');

    if (weatherResponse.statusCode == 200 &&
        forecastResponse.statusCode == 200) {
      return setState(() {
        weatherData =
            new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        forecastData =
            new ForecastData.fromJson(jsonDecode(forecastResponse.body));
        isLoading = false;
      });
    }

    setState(() {
     // print(isLoading.toString());
      isLoading = false;
    });
  }
}
