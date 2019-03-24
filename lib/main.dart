import 'views/MyLocationView.dart';
import 'package:flutter/material.dart';
import './views/ErrorView.dart';

main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = getErrorWidget;
    return MaterialApp(
      home: new MyLocationView( ),

    );
  }
}
