import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:localizer/views/TabsView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../libraries/globals.dart' as globals;

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool value = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _tempUnitKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _windUnitKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   // var orientation = MediaQuery.of(context).orientation;
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.teal,
        primarySwatch: Colors.teal,
        splashColor: Colors.teal,
        // used for card headers
        cardColor: Colors.grey[300],
        // used for field backgrounds
        backgroundColor: Colors.teal,
        // color outside the card
        primaryColor: Colors.teal,
        textTheme: TextTheme(
          button: TextStyle(color: Colors.teal),
          // style of button text
          subhead: TextStyle(color: Colors.black), // style of input text
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TabsView()));
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: _buildPortraitLayout()
          //   : _buildLandscapeLayout(),
        ),
      ),
    );
  }

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
        labelWidth: 120,
        children: <CardSettingsSection>[
          CardSettingsSection(
              header: CardSettingsHeader(
                label: 'Weather Preferences',
              ),
              children: <Widget>[
               _tempUnit(),
                _windUnit(),
              ]),
        ]);
  }

  CardSettingsListPicker _tempUnit() {
    return CardSettingsListPicker(
      key: _tempUnitKey,
      label: 'Temp Unit',
      initialValue: globals.tempUnit,
      hintText: 'Select One',
      options: <String>['Celsius', 'Fahrenheit','Kelvin'],
      values: <String>['C','F','K'],
      //  onSaved: (value) => _ponyModel.type = value,
      onChanged: (value) {
        setState(() {
          _saveTempUnit(value);
          print(value);
        });
        //    _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsListPicker _windUnit() {
    return CardSettingsListPicker(
      key: _windUnitKey,
      label: 'Wind Unit',
      initialValue: globals.windUnit,
      hintText: 'Select One',
      //  autovalidate: _autoValidate,
      options: <String>['Mile Per Hour','Kilometer Per Hour','Meter Per Second','Knots'],
      values: <String>['mph','km/h','m/s','kn'],
      onChanged: (value) {
        setState(() {
          _saveWindUnit(value);
        });
        //    _showSnackBar('Type', value);
      },
    );
  }

   Future<void> _saveWindUnit(String value) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       prefs.setString(globals.WIND_UNIT_PREF,value);
       globals.windUnit=value ;
     });
   }

  Future<void> _saveTempUnit(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString(globals.TEMP_UNIT_PREF,value);
      globals.tempUnit=value ;
    });
  }
}
