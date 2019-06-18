import 'dart:async';

import 'package:flutter/material.dart';
import 'TabsView.dart';
class splashView extends StatefulWidget {
  @override
  createState() =>_splashViewState();
}


  class _splashViewState extends State<splashView>{
  @override
  Widget build(BuildContext context) {
    setState(() {
      Timer(Duration(seconds: 3), () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TabsView()));
      });
    });
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
              child: Text("Localizator",
                style:TextStyle(
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
