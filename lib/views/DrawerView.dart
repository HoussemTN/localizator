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
  Future<List<Widget>> getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //return  a list (Keys ,values) of sharedPreferences where valid keys into a ListTile Widget
    return prefs
        .getKeys()
        .where((String key) =>
            key != "lib_cached_image_data" &&
            key != "lib_cached_image_data_last_clean")
        .map<Widget>((key) => ListTile(
              title: Text(key),
              onTap: () {
                List<String> spliterArr = prefs.get(key).toString().split(",");
                SearchFavoriteView.favoriteLat = double.tryParse(spliterArr[0]);
                SearchFavoriteView.favoriteLong =
                    double.tryParse(spliterArr[1]);
                SearchFavoriteView.FavoritePlaceName = key;
                SearchFavoriteView.isFavorite = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchFavoriteView()),
                );
              },
              subtitle: Text(prefs.get(key).toString()),
            ))
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
        ListTile(
          title: Text("Refresh"),
          onTap: () {
            setState(() {
              getAllPrefs();
            });
          },
        ),
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
                return Center(
                    child: new Text('Couldn\'t get Favorite Positions'));
              } else if (!snapshot.hasData)
                return Container(
                  child: Text("There is no Favorite Positions saved"),
                );
              else {
                return Column(children: snapshot.data);
              }
            }),
      ]),
    );
  }
}
