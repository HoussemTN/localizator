import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import "dart:math" as math;

class MyLocationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLocationViewState();
  }
}

class MyLocationViewState extends State<MyLocationView>
    with TickerProviderStateMixin {
  /// Controllor for FloatActionButtons
  AnimationController _controller;

  /// Icons List For FloatActionButtons
  static const List<IconData> icons = const [
    Icons.track_changes,
    Icons.content_copy
  ];

  ///will get currentLocation
  var currentLocation = LocationData;
  Location location = new Location();
  String error;
  static double lat;
  static double long;
  MapController mapController = new MapController();

  /// Is camera Position is moving default FALSE
  bool isMoving = false;

  initState() {
    super.initState();
    location.changeSettings(accuracy: LocationAccuracy.HIGH, interval: 1000);
    location.onLocationChanged().listen((LocationData result) {
      // print("Lat/LNG");
      setState(() {
        try {
          lat = result.latitude;
          long = result.longitude;
          //MoveCamera to the updated Position
          if (isMoving == true) {
            mapController.move(LatLng(lat, long), 10.0);
          }
        } catch (Exception, e) {
          lat = 0.0;
          long = 0.0;
          print(e.toString());
        }
        //print(lat.toString());
        // print(long.toString());
      });
    });
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  ///to compare with this icon
  Icon actionIcon = Icon(Icons.my_location);

  /// to retrieve the appbar title
  Widget appBarTitle = Text("Find Location");

  //to show a snackBar after copy
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;
    /// Show Snack Bar Messages
    _showSnackBar(String message) {
      final snackBar = SnackBar(
        content: Text('$message'),
          duration: Duration(seconds:1 )
      );
      mykey.currentState.showSnackBar(snackBar);
    }
    return Scaffold(
      key: mykey,
      body: Column(
        children: <Widget>[
          Expanded(
            child: new FlutterMap(
              mapController: mapController,
              options: new MapOptions(
                center: new LatLng(lat, long),
                minZoom: 2.0,
                zoom: 10,
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
                      point: new LatLng(lat, long),
                      builder: (ctx) => new Container(
                          child: IconButton(
                              icon: Icon(
                                Icons.adjust,
                                color: Colors.blue,
                              ),
                              onPressed: () {}),
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(100.0),
                            color: Colors.blue[100].withOpacity(0.7),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),

      ///floatingActionButtons
      floatingActionButton: new Column(
        mainAxisSize: MainAxisSize.min,
        children: new List.generate(icons.length, (int index) {
          Widget child = new Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: new ScaleTransition(
              scale: new CurvedAnimation(
                parent: _controller,
                curve: new Interval(0.0, 1.0 - index / icons.length / 2.0,
                    curve: Curves.easeOut),
              ),
              child: new FloatingActionButton(
                heroTag: null,
                backgroundColor: backgroundColor,
                mini: true,
                child: new Icon(icons[index], color: foregroundColor),
                onPressed: () {
                  ///onPress LockCamera button
                  if (index == 0) {
                    if (isMoving == false) {
                      isMoving = true;
                      _showSnackBar("Camera Lock Enabled!");
                    } else {
                      isMoving = false;
                      _showSnackBar("Camera Lock Disabled!");
                    }
                  ///OnPress CopyPosition button
                  }else if (index == 1) {
                    ///Copy Current Position
                    Clipboard.setData(new ClipboardData(text: "$lat,$long"));
                    _showSnackBar("Location Copied!");
                  }
                },
              ),
            ),
          );
          return child;
        }).toList()
          ..add(
            new FloatingActionButton(
              heroTag: null,
              child: new AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget child) {
                  return new Transform(
                    transform: new Matrix4.rotationZ(
                        _controller.value * 0.5 * math.pi),
                    alignment: FractionalOffset.center,
                    child: new Icon(
                        _controller.isDismissed ? Icons.add : Icons.close),
                  );
                },
              ),
              onPressed: () {
                if (_controller.isDismissed) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
          ),
      ),
    );
  }
}
