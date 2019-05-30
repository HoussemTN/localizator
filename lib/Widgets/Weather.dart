import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:localizer/models/WeatherData.dart';

class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //Main Column
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Place Name Main  information centred
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  //sunrise Card
                  Card(
                      child: Container(
                    width: MediaQuery.of(context).size.width / 3.6,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset(
                          'images/sunrise.png',
                          width: 40,
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                              '${new DateFormat.Hm().format(weather.sunrise)}',
                              style: new TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  )), // end sunrise Card

                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image.asset(
                            'images/date.png',
                            width: 40,
                            height: 30,
                          ),
                          Text(new DateFormat.yMMMd().format(weather.date),
                              style: new TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ), //end  Date Card
                  //sunset Card
                  Card(
                      child: Container(
                    width: MediaQuery.of(context).size.width / 3.6,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset(
                          'images/sunset.png',
                          width: 40,
                          height: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                              '${new DateFormat.Hm().format(weather.sunset)}',
                              style: new TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
              //TODO Add Background here
              Card(
                child: Column(
                  children: <Widget>[
                    Text(weather.name, style: new TextStyle(color: Colors.black)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Image.network(
                          'https://openweathermap.org/img/w/${weather.icon}.png'),
                    ),
                    Text(weather.main,
                        style:
                            new TextStyle(color: Colors.black, fontSize: 32.0)),
                  ],
                ),
                  ],
                ),
              ),
            ],
          ),

          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Temperature Card
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.9,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image.asset(
                            'images/temp.png',
                            width: 35,
                            height: 35,
                          ),
                          Text('${'Temp : ' + weather.temp.toString()}°C',
                              style: new TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ), //end Temperature Card
                  //Humidity Card
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image.asset(
                            'images/humidity.png',
                            width: 35,
                            height: 30,
                          ),
                          Text(
                              '${'Humidity : ' + weather.humidity.toString()} %',
                              style: new TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ), //end Temperature Card
                ],
              ), //end Row 1
              // Row 2
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Temperature Card
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.9,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image.asset(
                            'images/temp.png',
                            width: 35,
                            height: 35,
                          ),
                          Text('${'Temp : ' + weather.temp.toString()}°C',
                              style: new TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ), //end Temperature Card
                  //Humidity Card
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Image.asset(
                            'images/humidity.png',
                            width: 35,
                            height: 30,
                          ),
                          Text(
                              '${'Humidity : ' + weather.humidity.toString()} %',
                              style: new TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ), //end Temperature Card
                ],
              ), //end Row 2
            ],
          ),
        ],
      ),
    );
  }
}
