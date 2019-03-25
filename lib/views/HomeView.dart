import 'package:flutter/material.dart';
import 'MyLocationView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Home',
      home: new _HomeViewPage( ),
      routes: <String, WidgetBuilder>{
        '/MyLocation': (BuildContext context) => new MyLocationView( ),
      },
    );
  }
}

class _HomeViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text( 'Home Page' ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container( child: Image.asset( 'images/HomeImage.jpg' ) ),
              Container(
                margin: EdgeInsets.symmetric( vertical: 5.0, horizontal: 20.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text( "Find My Location" ),
                      onPressed: () =>
                          Navigator.pushNamed( context, '/MyLocation' ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric( vertical: 5.0, horizontal: 20.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text( "Search a Location" ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric( vertical: 5.0, horizontal: 20.0 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text( "About Localizer" ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ) );
  }
}
