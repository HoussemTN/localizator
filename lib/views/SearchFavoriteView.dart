import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:localizer/fix/bottom_sheet_fix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DrawerView.dart';
import 'FavoriteLocationDropDownView.dart';
import '../libraries/secrets.dart' as secrets;

// ignore: must_be_immutable
class SearchFavoriteView extends StatefulWidget {
  double lat = 0.00;
  double long = 0.00;
  static double favoriteLat;
  static double favoriteLong;
  static bool isFavorite = false;
  static String favoritePlaceName = "Favorite Place";
  static String locationImage;


  @override
  _SearchFavoriteViewState createState() => _SearchFavoriteViewState(lat, long);
}

class _SearchFavoriteViewState extends State<SearchFavoriteView> {
  //changes after declaring the desired location
  Widget _searchView;
  double lat ;
  double long ;
  String placeName = SearchFavoriteView.favoritePlaceName;
  String placePosition = "";
  final myController = TextEditingController();
  final favoritePlaceController = TextEditingController();


  // Constructor
  _SearchFavoriteViewState(double long, double lat) {
    this.lat = lat;
    this.long = long;
  }
  _favoritePlaces(String oldPlaceName,double lat ,double long) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    /// get the favorite position then added to prefs
    placeName = favoritePlaceController.text;

    ///convert position to string and concat it
    placePosition = lat.toString() +
        ',' +
        long.toString() +
        ',' +
        FavoriteLocationDropDown.currentImage.toString();
    print('Place Name $placeName => $placePosition Captured.');
    await prefs.setString(
      '$placeName',
      '$placePosition',
    );
    if(oldPlaceName!=placeName) {
      ///remove old record
      prefs.remove( oldPlaceName );
    }
  }
  //declaring Bottom sheet widget
  Widget buildSheetLogin(BuildContext context) {
    favoritePlaceController.text=placeName;
    return new Container(
      child: Wrap(children: <Widget>[
        Container(
          padding: new EdgeInsets.only(left: 10.0, top: 10.0),
          width: MediaQuery.of(context).size.width / 1.7,
          child: Form(
            key: _formKey,
            child: TextFormField(
              controller: favoritePlaceController,
              validator: (String val){
                if(val.length==0){
                  return 'Empty Name';
                }
                return null ;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                /// focused border color (erasing theme default color [teal])
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.black)),
                      /// Display Old PlaceName Value
                     labelText: "$placeName",
                prefixIcon: Icon(
                  Icons.save_alt,
                  color: Colors.teal,
                ),
              ),
            ),
          ),
        ),
        Container(child: FavoriteLocationDropDown()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: RaisedButton(
                color: Colors.teal,
                textColor: Colors.white,
                child: Text("Save"),
                onPressed: () {
    if (_formKey.currentState.validate()) {
      _favoritePlaces( placeName, SearchFavoriteView.favoriteLat,
          SearchFavoriteView.favoriteLong );
      Navigator.pop( context );
    }
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }
  _searchedLocation(double lat, double long) {
    if (SearchFavoriteView.isFavorite == true) {
      lat = SearchFavoriteView.favoriteLat;
      long = SearchFavoriteView.favoriteLong;
      SearchFavoriteView.isFavorite = false;
      _searchView = Column(
        children: <Widget>[
          Expanded(
            child: new FlutterMap(
              options: new MapOptions(
                center: new LatLng(lat, long),
                minZoom: 2.0,
                zoom: 14,
              ),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tiles.mapbox.com/v4/"
                      "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken':
                    secrets.accessToken,
                    'id': 'mapbox.streets',
                  },
                ),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 60.0,
                      height: 60.0,
                      point: new LatLng(lat, long),
                      builder: (ctx) => new Container(

                        child: FlatButton(
                            child: Image.asset(
                                SearchFavoriteView.locationImage ),
                            onPressed: null ),
                        /* decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100.0),
                            color: Colors.blue[100].withOpacity(0.7),
                          )*/ ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    }
    return _searchView;
  }
  final _formKey = GlobalKey<FormState>();
  @override

  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.teal),
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(placeName),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          ),
        ),
        drawer: DrawerView(),
        body: _searchedLocation(this.lat, this.long),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: "btn1",
          onPressed: () {
            // Calling bottom sheet Widget
            showModalBottomSheetApp(
                context: context,
                builder: (builder) {
                  return buildSheetLogin(context);
                });
          },
          tooltip: 'Edit',
          icon: Icon(Icons.edit),
          label: Text("Edit"),
        ),
      ),
    );
  }
}
