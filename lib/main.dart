import 'package:flutter/material.dart';
import './views/ErrorView.dart';
import './views/TabsView.dart';
import 'libraries/globals.dart' as globals;
import 'package:location/location.dart';
main() {

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {

  runApp( MyApp( ) );
  // });
}



class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  //will get currentLocation


  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = getErrorWidget;
    return TabsView( );
  }
}
