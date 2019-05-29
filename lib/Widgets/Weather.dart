import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:localizer/models/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Row(
          children: <Widget>[
            //sunrise Card
            Card(

                child: Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset('images/sunrise.png',width: 40,height:35 ,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                        '${new DateFormat.Hm().format(weather.sunrise)}',
                        style: new TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            )),
            //sunset Card
            Card(
                child: Container(
              width: MediaQuery.of(context).size.width / 2.2,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                new Image.asset('images/sunset.png',width: 40,height:35 ,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('${new DateFormat.Hm().format(weather.sunset)}',
                        style: new TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            )),
          ],
        ),
              //TODO Add Background here
        Text(weather.name, style: new TextStyle(color: Colors.black)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
            ),
            Text(weather.main, style: new TextStyle(color: Colors.black, fontSize: 32.0)),
          ],
        ),
        Text('${weather.temp.toString()}°C',
            style: new TextStyle(color: Colors.black)),

        Text(new DateFormat.yMMMd().format(weather.date),
            style: new TextStyle(color: Colors.black)),
        // Weather Date
        Text(new DateFormat.Hm().format(weather.date),
            style: new TextStyle(color: Colors.black)),
        Text('${"Humidité : " + weather.humidity.toString()} %',
            style: new TextStyle(color: Colors.black)),
      ],
    );
  }
}
