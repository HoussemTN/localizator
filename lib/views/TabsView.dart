import 'package:flutter/material.dart';
import 'MyLocationView.dart';
import 'HomeView.dart';
import 'SearchView.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabsView extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<TabsView> {
  Future<List<Widget>> getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance( );
    //return  a list (Keys ,values) of sharedPreferences where valid keys into a ListTile Widget
    return prefs
        .getKeys( )
        .where( (String key) =>
    key != "lib_cached_image_data" &&
        key != "lib_cached_image_data_last_clean" )
        .map<Widget>( (key) =>
        ListTile(
          title: Text( key ),
          onTap: () {

          },
          subtitle: Text( prefs.get( key ).toString( ) ),
        ) )
        .toList( growable: true );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.teal),
      title: 'Home',
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Localizer'),
              bottom: TabBar(tabs: <Widget>[
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.my_location), text: 'Find Location'),
                Tab(icon: Icon(Icons.search), text: 'Search Location'),
              ]),
            ),
            drawer: Drawer(
              child: ListView( padding: EdgeInsets.zero, children: <Widget>[
                DrawerHeader(
                  child: Text(
                    'Favorite Places',
                    style: TextStyle( fontSize: 20.0, color: Colors.white ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                ),
                FutureBuilder<List<Widget>>(
                    future: getAllPrefs( ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Text( "hello" ),
                        );
                      else {
                        return Column( children: snapshot.data );
                      }
                    } ),
              ] ),
            ),
            body: TabBarView(
              //disable tabs scroll
                physics: NeverScrollableScrollPhysics( ),
                children: <Widget>[
                  HomeView( ),
                  MyLocationView( ),
                  SearchView( ),
                ] ) ),
      ),
    );
  }
}
