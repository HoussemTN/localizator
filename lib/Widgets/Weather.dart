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
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Place Name Main  information centred
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //sunrise Card
                    Card(
                        child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            'images/sunrise.png',
                            width: MediaQuery.of(context).size.width / 12,
                            height: MediaQuery.of(context).size.height,
                          ),
                          Text('${new DateFormat.Hm().format(weather.sunrise)}',
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                        ],
                      ),
                    )), // end sunrise Card

                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset(
                              'images/date.png',
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Text(new DateFormat.yMMMd().format(weather.date),
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          ],
                        ),
                      ),
                    ), //end  Date Card
                    //sunset Card
                    Card(
                        child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            'images/sunset.png',
                            width: MediaQuery.of(context).size.width / 12,
                            height: MediaQuery.of(context).size.height,
                          ),
                          Text('${new DateFormat.Hm().format(weather.sunset)}',
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 16.0)),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              Card(
                child: Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage(
                          'images/weatherMain/${weather.main}.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.gps_fixed,
                              color: Colors.white,
                            ),
                            Text(
                              weather.name,
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.network(
                              'https://openweathermap.org/img/w/${weather.icon}.png'),
                          Text(weather.main,
                              style: new TextStyle(
                                  color: Colors.black, fontSize: 32.0)),
                        ],
                      ),
                      //show Current Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Icon(
                              Icons.update,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, bottom: 8.0),
                            child: Text(
                                '${new DateFormat.Hm().format(weather.date)}',
                                style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //Temperature Card
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset(
                              'images/temp.png',
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Text(
                                '${'Temp : ' + weather.temp.toStringAsFixed(2)}°C',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          ],
                        ),
                      ),
                    ), //end Temperature Card
                    //Humidity Card
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset(
                              'images/humidity.png',
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Text(
                                '${'Humidity : ' + weather.humidity.toString()} %',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
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
                    //WindSpeed Card
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset(
                              'images/wind.png',
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Text(
                                '${'Wind : ' + weather.windSpeed.floor().toString()} km/h',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          ],
                        ),
                      ),
                    ), //end WindSpeed Card
                    //pressure Card
                    Card(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Image.asset(
                              'images/pressure.png',
                              width: MediaQuery.of(context).size.width / 12,
                              height: MediaQuery.of(context).size.height,
                            ),
                            Text(
                                '${'Pressure : ' + weather.pressure.toString()}',
                                style: new TextStyle(
                                    color: Colors.black, fontSize: 16.0)),
                          ],
                        ),
                      ),
                    ), //end pressure Card
                  ],
                ), //end Row 2
              ],
            ),
          ),
        ],
      ),
    );
  }
}
