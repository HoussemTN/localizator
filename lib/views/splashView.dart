import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../libraries/globals.dart' as globals;

class SplashView extends StatefulWidget {
  @override
  createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer timer ;
  @override
  void initState() {
    _getWeatherPreferences();
   timer = Timer(
       Duration(seconds: 1),
           () => Navigator.pushReplacementNamed(context,"TabsView" ));
   super.initState();
  }

  @override
  void dispose() {
  timer.cancel();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: 144,
              height: 144,
              child: Image.asset("images/splash/splash.png"),
            ),
          ),
          Center(
            child: Container(
              child: Text(
                "Locativity",
                style: TextStyle(
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _getWeatherPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      globals.tempUnit=prefs.getString(globals.TEMP_UNIT_PREF);
      if(globals.tempUnit==null){
        globals.tempUnit=globals.DEFAULT_TEMP_UNIT;
      }
      globals.windUnit=prefs.getString(globals.WIND_UNIT_PREF);
      if(globals.windUnit==null){
        globals.windUnit=globals.DEFAULT_WIND_UNIT;
      }
      print('temp Unit:'+globals.tempUnit);
      print('wind Unit:'+globals.windUnit);
    });

  }
}
