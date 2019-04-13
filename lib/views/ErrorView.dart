import 'package:flutter/material.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:carousel_slider/carousel_slider.dart';

List _tips = [
  ('      Searching...'),
  ('Tips :Turn On Wifi'),
  ('Tips :Turn On GPS'),
];
int i = 0;

// ignore: missing_return
Widget getErrorWidget(FlutterErrorDetails error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AwesomeLoader(
          loaderType: AwesomeLoader.AwesomeLoader3,
          color: Colors.teal,
        ),
        Center(
          child: CarouselSlider(
            height: 60.0,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: Duration( seconds: 3 ),
            autoPlayAnimationDuration: Duration( milliseconds: 800 ),
            items: _tips.map( (i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: 140.0,
                      child: Text(
                        ' $i ',
                        style: TextStyle( fontSize: 16.0 ),
                      ) );
                },
              );
            } ).toList( ),
          ),
        ),
      ],
    ),
  );
}
