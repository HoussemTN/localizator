import 'package:flutter/material.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:carousel_slider/carousel_slider.dart';

List _tips = [
  ('Turn On Wifi'),
  ('Turn On GPS'),
];
int i = 0;

Widget getErrorWidget(FlutterErrorDetails error) {
  return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text( 'Localizer' ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text( "Oops..Something Went Wrong" ),
              ),
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
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  items: _tips.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: 140.0,
                            child: Text(
                              'Tips : $i ',
                              style: TextStyle(fontSize: 16.0),
                            ));
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ));
}
