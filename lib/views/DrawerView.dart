import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SearchFavoriteView.dart';

class DrawerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerViewState();
  }
}

class DrawerViewState extends State<DrawerView> {
  //return a specific value order of index : [0]=>lat,[1]=>long,[2]=>ImageUrl
  String _getPrefData(String values, int index) {
    List<String> _spliterArr = values.split( "," );
    return _spliterArr[index].toString( );
  }

  Future<List<Widget>> getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //return  a list (Keys ,values) of sharedPreferences and not cache records
    return prefs
        .getKeys()
        .where((String key) =>
    key != "lib_cached_image_data" &&
        key != "lib_cached_image_data_last_clean" )
        .map<Widget>((key) => ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset( _getPrefData( prefs.get( key ), 2 ) ),
      ),
      subtitle: Text( "" +
          _getPrefData( prefs.get( key ), 0 ) +
          ',' +
          _getPrefData( prefs.get( key ), 1 ) ),
      title: Text( key ),
      onTap: () {
        List<String> splitArr = prefs.get( key ).toString( ).split( "," );
        SearchFavoriteView.favoriteLat = double.tryParse( splitArr[0] );
        SearchFavoriteView.favoriteLong = double.tryParse( splitArr[1] );
        SearchFavoriteView.locationImage = splitArr[2];
        print( splitArr[2] );
        SearchFavoriteView.favoritePlaceName = key;
        SearchFavoriteView.isFavorite = true;
        Navigator.push(
          context,
          MaterialPageRoute( builder: (context) => SearchFavoriteView( ) ),
        );
      },
    ) )
        .toList(growable: true);
  }

  void deleteAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
          child: Text(
            'Favorite Places',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          decoration: BoxDecoration(
            color: Colors.teal,
          ),
        ),
        //refresh button
        /* ListTile(
          title: Text("Refresh"),
          onTap: () {
            setState(() {
              getAllPrefs();
            });
          },
        ),*/
        ListTile(
          title: Text("Delete All"),
          onTap: () {
            setState(() {
              deleteAllPrefs();
            });
          },
        ),
        FutureBuilder<List<Widget>>(

          //  getAllPrefs return List of Widgets
            future: getAllPrefs(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return ListTile(
                  title: Text( "Couldn\'t get Favorite Positions" ),
                );
              } else if (!snapshot.hasData)
                return ListTile(
                  title: Text( "No Favorite Positions Saved" ),
                );
              else {
                return Column(children: snapshot.data);
              }
            }),
      ]),
    );
  }
}
