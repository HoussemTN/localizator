import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './views/ErrorView.dart';
import './views/TabsView.dart';
import './views/splashView.dart';

main() {
  runApp( MyApp( ) );
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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


