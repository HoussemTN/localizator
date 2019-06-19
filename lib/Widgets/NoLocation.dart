import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:localizer/libraries/globals.dart' as globals;

class NoLocation extends StatefulWidget {
  @override
  _NoLocationState createState() => _NoLocationState();
}

class _NoLocationState extends State<NoLocation> {
  List _tips = [
    ('Searching...'),
    ('Turn On Wifi'),
    ('Turn On GPS'),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: CarouselSlider(
              height: 20.0,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 1000),
              items: _tips.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: 97.0,
                        child: Text(
                          ' $i ',
                          style: TextStyle(fontSize: 16.0),
                        ));
                  },
                );
              }).toList(),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                valueColor: new AlwaysStoppedAnimation(Colors.teal),
              ),
            ),
          ),
          RaisedButton(
            child: Text("Retry"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "TabsView");
            },
          ),
        ],
      ),
    );
  }
}
