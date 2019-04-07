
import 'package:flutter/material.dart';
import './views/ErrorView.dart';
import './views/HomeView.dart';
main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = getErrorWidget;
    return HomeView();
  }
}
