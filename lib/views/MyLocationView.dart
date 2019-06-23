import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import '../libraries/globals.dart' as globals;
import "dart:math" as math;
import 'package:app_settings/app_settings.dart';

class MyLocationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLocationViewState();
  }
}

class MyLocationViewState extends State<MyLocationView>
    with TickerProviderStateMixin {
  ///=========================================[Declare]=============================================
  /// Controllor for FloatActionButtons
  AnimationController _controller;

  /// Icons List For FloatActionButtons
  List<IconData> icons = [Icons.gps_fixed, Icons.content_copy];

  var geolocator = Geolocator()..forceAndroidLocationManager = true;

  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 0);

  double lat;
  double long;
  double _outZoom = 2.0;
  double _inZoom = 15.0;
  MapController mapController = new MapController();

  /// Is camera Position Lock is enabled default false
  bool isMoving = false;

  ///=========================================[initState]=============================================
  void _showDialog(String body) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Location Permission"),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                child: Text("close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Settings"),
                onPressed: () {
                  AppSettings.openLocationSettings();
                },
              ),
            ],
          );
        });
  }

  initState() {
    super.initState();

    if (long == null || lat == null) {
      ///checks GPS then call localize

      _checkGPS();
    } else {
      /// GPS is Okey just localize
      localize();
    }

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void localize() {
    geolocator.getPositionStream(locationOptions).listen((Position position) {
      if (!mounted) {
        return;
      }
      if (mounted) {
        setState(() {
          this.lat = position.latitude;
          this.long = position.longitude;
          globals.long = long;
          globals.lat = lat;
          if (isMoving = true) {
            mapController.move(LatLng(lat, long), _inZoom);
            icons[0] = Icons.gps_fixed;
          }
        });
      }
    });
  }

  _checkGPS() async {
    /// when back to this tab should get previous position from libraries
    if (mounted && globals.lat != null && globals.long != null) {
      setState(() {
        lat = globals.lat;
        long = globals.long;
      });
    }
    var status = await geolocator.checkGeolocationPermissionStatus();

    if (status == GeolocationStatus.granted &&
        await geolocator.isLocationServiceEnabled() == true) {
      /// Localize Position
      localize();
      isMoving = true;
      mapController.move(LatLng(lat, long), _inZoom);
      icons[0] = Icons.gps_fixed;
    } else {
      _showDialog("Turn On Yuur GPS");
    }
  }

  ///to show a snackBar after copy
  final GlobalKey<ScaffoldState> mykey = new GlobalKey<ScaffoldState>();

  ///=========================================[BUILD]=============================================
  @override
  Widget build(BuildContext context) {
    Widget _loadBuild() {
      ///[Position Found Render Marker]
      if (lat != null && long != null) {
        return Expanded(
          child: new FlutterMap(
            mapController: mapController,
            options: new MapOptions(
              center: new LatLng(lat, long),
              zoom: _inZoom,
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
                            onPressed: null),
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.circular(100.0),
                          color: Colors.blue[100].withOpacity(0.7),
                        )),
                  ),
                ],
              ),
            ],
          ),
        );
      } else {
        setState(() {
          icons[0] = Icons.gps_not_fixed;
        });

        ///[Position Not Found/Not Found yet]
        return Expanded(
          child: new FlutterMap(
            mapController: mapController,
            options: new MapOptions(
              zoom: _outZoom,
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
            ],
          ),
        );
      }
    }

    ///Float Action Button Background Color
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    /// Show Snack Bar Messages
    _showSnackBar(String message) {
      final snackBar =
          SnackBar(content: Text('$message'), duration: Duration(seconds: 1));
      mykey.currentState.showSnackBar(snackBar);
    }

    /// returned build
    return Scaffold(
      key: mykey,
      body: Column(
        children: <Widget>[_loadBuild()],
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
                    /// if Camera not locked
                    if (isMoving == false) {
                      /// if position not null [LatLng]
                      if (lat != null && long != null) {
                        setState(() {
                          ///change icon to lockedCamera
                          icons[index] = Icons.gps_fixed;
                          isMoving = true;
                        });
                        mapController.move(LatLng(lat, long), _inZoom);
                        _showSnackBar("Camera Lock Enabled!");
                      } else {
                        _showSnackBar("Couldn't get your Position!");
                      }
                    } else {
                      setState(() {
                        icons[index] = Icons.gps_not_fixed;
                        isMoving = false;
                      });

                      _showSnackBar("Camera Lock Disabled!");
                    }

                    ///OnPress CopyPosition button
                  } else if (index == 1) {
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
