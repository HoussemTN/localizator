import 'package:flutter/material.dart';
int i = 0;
// ignore: missing_return
Widget getErrorWidget(FlutterErrorDetails error) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child:Text("Error Occured"),
        )
      ],
    ),
  );
}
