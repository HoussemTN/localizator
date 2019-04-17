import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class MyLocationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLocationViewState();
  }
}

class MyLocationViewState extends State<MyLocationView> {
  //will get currentLocation
  var currentLocation = LocationData;
  Location location = new Location();
  String error;
  double lat;
  double long;

  initState() {
    super.initState();
    location.onLocationChanged().listen((LocationData result) {
      // print("Lat/LNG");
      try {
      lat = result.latitude;
      long = result.longitude;
      } catch (Exception, e) {
        lat = -1.0;
        long = -1.0;
        print( e.toString( ) );
      }
      setState(() {
        //print(lat.toString());
        // print(long.toString());
      });
    });
  }

  //to compare with this icon
  Icon actionIcon = Icon( Icons.my_location );

  // to retrieve the appbar title
  Widget appBarTitle = Text( "Find Location" );

  //to show a snackBar after copy
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>( );
  @override
  Widget build(BuildContext context) {
    _showSnackBar() {
      // print( 'SnackBar Code Executed' );
      final snackBar = SnackBar(
        content: Text( 'Location Copied!' ),
      );
      mykey.currentState.showSnackBar( snackBar );
    }

    return Scaffold(
      key: mykey,
      body: Column(

        children: <Widget>[
          Expanded(
            child: new FlutterMap(
              options: new MapOptions(
                center: new LatLng( lat, long ),
                minZoom: 2.0,
                zoom: 17,
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Clipboard.setData( new ClipboardData( text: "$lat,$long" ) );
          _showSnackBar( );
        },
        tooltip: 'Get your position',
        icon: Icon( Icons.content_copy ),
        label: Text( "Copy Position" ),
      ),
    );
  }
}
