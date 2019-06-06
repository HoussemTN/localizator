import 'package:flutter/material.dart';
import 'MyLocationView.dart';
import 'SearchView.dart';
import 'DrawerView.dart';
import 'WeatherView.dart';

class TabsView extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<TabsView> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      title: 'Home',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Localizer'),
              bottom: TabBar(tabs: <Widget>[
                //Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.my_location), text: 'Location'),
                Tab(icon: Icon(Icons.cloud), text: 'Weather'),
                Tab(icon: Icon(Icons.search), text: 'Search'),
              ]),
            ),
            drawer: DrawerView(),
            body: TabBarView(
              //disable tabs scroll
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  // HomeView(),
                  MyLocationView(),
                  WeatherView(),
                  SearchView(),
                ])),
      ),
    );
  }
}