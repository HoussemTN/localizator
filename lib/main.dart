import 'package:flutter/material.dart';
import './views/ErrorView.dart';
import './views/TabsView.dart';

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
  home:TabsView(),
  );

  }
}


