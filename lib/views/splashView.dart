import 'dart:async';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer timer ;
  @override
  void initState() {
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
}
