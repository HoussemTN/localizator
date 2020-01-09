import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../fix/bottom_sheet_fix.dart';
import 'SearchFavoriteView.dart';
import 'FavoriteLocationDropDownView.dart';
import '../libraries/secrets.dart' as secrets;
class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //to retrieve position from TextField
  final myController = TextEditingController();
  final favoritePlaceController = TextEditingController();

  ///changes after declaring the desired location
  Widget _searchView;
  double lat = 0.00;
  double long = 0.00;
  bool _empty = false;
  String placeName = "";
  String placePosition = "";

  _favoritePlaces() async {
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

    /// clear Text Field after adding position to favorite places
    favoritePlaceController.clear();
  }

  //declaring Bottom sheet widget
  Widget buildSheetLogin(BuildContext context) {
    return new Container(
      child: Wrap(children: <Widget>[
        Container(
          padding: new EdgeInsets.only(left: 10.0, top: 10.0),
          width: MediaQuery.of(context).size.width / 1.7,
          child: TextFormField(
            controller: favoritePlaceController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              // focused border color (erasing theme default color [teal])
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.black)),
              labelText: "Place name",
              hintText: "Enter Place Name",
              prefixIcon: Icon(
                Icons.save_alt,
                color: Colors.teal,
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
                  _favoritePlaces();
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ]),
    );
  }

  /* void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }*/

  _searchedLocation(double lat, double long) {
    if ((lat == 0.00 || long == 0.00) &&
        SearchFavoriteView.isFavorite == false) {
      Column(
        children: <Widget>[
          _searchView = Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("images/searchLocation.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    cursorColor: Colors.black,
                    controller: myController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.location_searching,
                        color: Colors.teal,
                      ),

                      //border color
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      // focused border color (erasing theme default color [teal])
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      errorText: _empty ? 'Invalid Position' : null,
                      hintText: 'Enter Latitude,Longitude',
                      hintStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                    ),
                    style: TextStyle(fontSize: 20.00, color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      child: Text("Search"),
                      color: Colors.teal,
                      textColor: Colors.white,
                      onPressed: () {
                        myController.text.isEmpty
                            ? _empty = true
                            : _empty = false;
                        setState(
                          () {
                            //TexField not empty
                            if (_empty == false) {
                              //Split entry position and parse it
                              List<String> _position =
                                  myController.text.split(",");
                              this.lat = double.tryParse(_position[0]);
                              this.long = double.tryParse(_position[1]);
                              // print("LAT/LONG" + '$lat' + "/" + '$long');
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      if (SearchFavoriteView.isFavorite == true) {
        lat = SearchFavoriteView.favoriteLat;
        long = SearchFavoriteView.favoriteLong;
        SearchFavoriteView.isFavorite = false;
      }
      _searchView = Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Column(
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
                        width: 50.0,
                        height: 50.0,
                        point: new LatLng(lat, long),
                        builder: (ctx) => new Container(
                          child: IconButton(
                              icon: Icon(Icons.adjust, color: Colors.blue),
                              onPressed: () {}),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100.0),
                            color: Colors.blue[100].withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
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
          tooltip: 'Favorite',
          icon: Icon(Icons.favorite),
          label: Text("Favorite"),
        ),
      );
    }
    return _searchView;
  }

  @override
  Widget build(BuildContext context) {
    return _searchedLocation(this.lat, this.long);
  }
}
