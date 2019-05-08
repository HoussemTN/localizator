import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'DrawerView.dart';

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
  double lat = 0.00;
  double long = 0.00;
  String placeName = SearchFavoriteView.favoritePlaceName;
  String placePosition = "";
  final myController = TextEditingController();
  final favoritePlaceController = TextEditingController();

  // Constructor
  _SearchFavoriteViewState(double long, double lat) {
    this.lat = lat;
    this.long = long;
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
                        'pk.eyJ1IjoiaG91c3NlbXRuIiwiYSI6ImNqc3hvOG82NTA0Ym00YnI1dW40M2hjMjAifQ.VlQl6uacopBKX__qg6cf3w',
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
      ),
    );
  }
}
