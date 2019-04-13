import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  //to retrieve position from TextField
  final myController = TextEditingController( );

  //changes after declaring the desired location
  Widget _searchView;
  double lat = 0.00;
  double long = 0.00;

  bool _empty = false;

  /* void dispose() {
    // Clean up the controller when the Widget is disposed
    myController.dispose();
    super.dispose();
  }*/

  _searchedLocation(double lat, double long) {
    if (lat == 0.00 || long == 0.00) {
      _searchView = Container(
        child: Padding(
          padding: const EdgeInsets.all( 8.0 ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: myController,
                  decoration: InputDecoration(
                    prefixIcon: Icon( Icons.location_searching ),
                    border: OutlineInputBorder( ),
                    errorText: _empty ? 'Invalid Position' : null,
                    hintText: 'Enter Latitude,Longitude',
                  ),
                  style: TextStyle( fontSize: 20.00 ),
                ),
                Padding(
                    padding: const EdgeInsets.all( 8.0 ),
                    child: RaisedButton(
                      child: Text( "Search" ),
                      color: Colors.teal,
                      textColor: Colors.white,
                      onPressed: () {
                        myController.text.isEmpty
                            ? _empty = true
                            : _empty = false;
                        setState( () {
                          //TexField not empty
                          if (_empty == false) {
                            //Split entry position and parse it
                            List<String> _position =
                            myController.text.split( "," );
                            this.lat = double.tryParse( _position[0] );
                            this.long = double.tryParse( _position[1] );
                            print( "LAT/LONG" + '$lat' + "/" + '$long' );
                          }
                        } );
                      },
                    ) ),
              ] ),
        ),
      );
    } else {
      _searchView = Column(
        children: <Widget>[
          Expanded(
            child: new FlutterMap(
              options: new MapOptions(
                center: new LatLng( lat, long ),
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
                      width: 50.0,
                      height: 50.0,
                      point: new LatLng( lat, long ),
                      builder: (ctx) =>
                      new Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.adjust,
                                color: Colors.blue,
                              ),
                              onPressed: () {} ),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular( 100.0 ),
                            color: Colors.blue[100].withOpacity( 0.7 ),
                          ) ),
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
    return _searchedLocation( this.lat, this.long );
  }
}
