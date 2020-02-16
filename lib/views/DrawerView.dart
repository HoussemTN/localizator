import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SearchFavoriteView.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../libraries/globals.dart' as globals;

class DrawerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerViewState();
  }
}

class DrawerViewState extends State<DrawerView> {
  //return a specific value order of index : [0]=>lat,[1]=>long,[2]=>ImageUrl
  String _getPrefData(String values, int index) {
    List<String> _spliteArr = values.split(",");
    return _spliteArr[index].toString();
  }

  Future<List<Widget>> getAllPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    ///return  favorite places as list (Keys ,values) of sharedPreferences and not cache(map) nor other app prefs records
    return prefs
        .getKeys()
        .where((String key) =>
            key != "lib_cached_image_data" &&
            key != "lib_cached_image_data_last_clean" &&
            key != globals.TEMP_UNIT_PREF &&
            key != globals.WIND_UNIT_PREF)
        .map<Widget>((key) => Row(children: <Widget>[
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset(_getPrefData(prefs.get(key), 2)),
                  ),
                  title: Text(key),
                  subtitle: Text("" +
                      _getPrefData(prefs.get(key), 0) +
                      ',' +
                      _getPrefData(prefs.get(key), 1)),
                  onTap: () {
                    List<String> splitArr =
                        prefs.get(key).toString().split(",");
                    SearchFavoriteView.favoriteLat =
                        double.tryParse(splitArr[0]);
                    SearchFavoriteView.favoriteLong =
                        double.tryParse(splitArr[1]);
                    SearchFavoriteView.locationImage = splitArr[2];
                    print(splitArr[2]);
                    SearchFavoriteView.favoritePlaceName = key;
                    SearchFavoriteView.isFavorite = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchFavoriteView()),
                    );
                  },
                ),
              ),

              /// Copy Button for every LitTile
              IconButton(
                  icon: Icon(Icons.content_copy),
                  iconSize: 20,
                  color: Colors.grey[500],
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(
                        text:
                            "${_getPrefData(prefs.get(key), 0)} ,${_getPrefData(prefs.get(key), 1)}"));
                    Fluttertoast.showToast(
                        msg: "Copied!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.grey[400],
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }),
            ]))
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
            '',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/drawerHeader.jpg'),
              fit: BoxFit.cover,
            ),
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
          leading: Icon(
            Icons.delete,
            color: Colors.redAccent,
            size: 32,
          ),
          title: Text("Delete All "),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.warning,
                          color: Colors.redAccent,
                          size: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text("Are you sure ?"),
                        ),
                      ],
                    ),
                    content: Text(
                        "Do you really want to delete these records? This process cannot be undone."),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text("Delete"),
                        onPressed: () {
                          setState(() {
                            deleteAllPrefs();
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
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
                  child: Container(),
                );
              } else if (snapshot.hasError) {
                return ListTile(
                  title: Text("Couldn\'t get Favorite Positions"),
                );
              } else if (!snapshot.hasData)
                return ListTile(
                  title: Text("No Favorite Positions Saved"),
                );
              else {
                return Column(children: snapshot.data);
              }
            }),
      ]),
    );
  }
}
