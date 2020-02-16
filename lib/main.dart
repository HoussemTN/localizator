import 'package:flutter/material.dart';
import './views/ErrorView.dart';
import './views/TabsView.dart';
import './views/splashView.dart';

main() {

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  runApp( MyApp( ) );

  //});

}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = getErrorWidget;
  return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    routes: {
      'TabsView':(context)=>TabsView(),
    },
  home:SplashView(),
  );

  }
}


