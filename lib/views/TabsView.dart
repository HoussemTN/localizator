import 'package:flutter/material.dart';
import 'package:localizer/views/SettingsView.dart';
import 'MyLocationView.dart';
import 'SearchView.dart';
import 'DrawerView.dart';
import 'WeatherView.dart';
import 'ErrorView.dart';

class TabsView extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<TabsView> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = getErrorWidget;
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
            title: Text('Locativity'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.tune,
                  ),
                  onPressed: (){
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsView()));
                  }),
            ],
            bottom: TabBar(tabs: <Widget>[
              //Tab(icon: Icon(Icons.home), text: 'Home'),
              new Container(
                height: 65,
                child: Tab(icon: Icon(Icons.my_location), text: 'Location'),
              ),
              new Container(
                height: 65,
                child: Tab(icon: Icon(Icons.cloud), text: 'Weather'),
              ),
              new Container(
                height: 65,
                child: Tab(icon: Icon(Icons.search), text: 'Search'),
              ),
            ]),
          ),
          drawer: DrawerView(),
          body: TabBarView(
            /// disable tabs scroll
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              // HomeView(),
              MyLocationView(),
              WeatherView(),
              SearchView(),
            ],
          ),
        ),
      ),
    );
  }
}
