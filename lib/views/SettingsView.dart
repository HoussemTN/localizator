import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';

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
    var orientation = MediaQuery.of(context).orientation;
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
            onPressed: ()=>Navigator.of(context).pop(),
          ),
        ),
        body: Form(
          key: _formKey,
          child: (orientation == Orientation.portrait)
              ? _buildPortraitLayout()
              : Container(),
          //   : _buildLandscapeLayout(),
        ),
      ),
    );
  }

  CardSettings _buildPortraitLayout() {
    return CardSettings.sectioned(
        labelWidth: 100,
        children: <CardSettingsSection>[
          CardSettingsSection(
              header: CardSettingsHeader(
                label: 'Weather Preferences',
              ),
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(
                    primaryColor: Colors.teal,

                    primaryTextTheme: TextTheme(
                      title: TextStyle(color: Colors.white),
                      /// Dialog title color
                      body1: TextStyle(color: Colors.white),
                      // style for headers
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: Colors.black),
                      // style for labels
                    ),
                  ),
                  child: _tempUnit(),
                ),
                _windUnit(),
              ]),
        ]);
  }

  CardSettingsListPicker _tempUnit() {
    return CardSettingsListPicker(
      key: _tempUnitKey,
      label: 'Temp Unit',
      //  initialValue: _ponyModel.type,
      hintText: 'Select One',
      //  autovalidate: _autoValidate,
      options: <String>['Celsius', 'Fahrenheit','Kelvin'],
      values: <String>['C', 'F','K'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      //  onSaved: (value) => _ponyModel.type = value,
      onChanged: (value) {
        setState(() {
          //     _ponyModel.type = value;
        });
        //    _showSnackBar('Type', value);
      },
    );
  }

  CardSettingsListPicker _windUnit() {
    return CardSettingsListPicker(
      key: _windUnitKey,
      label: 'Wind Unit',
      //  initialValue: _ponyModel.type,
      hintText: 'Select One',
      //  autovalidate: _autoValidate,
      options: <String>['mph','knots','km/h'],
      values: <String>['M','K','KM'],
      validator: (String value) {
        if (value == null || value.isEmpty) return 'You must pick a type.';
        return null;
      },
      //  onSaved: (value) => _ponyModel.type = value,
      onChanged: (value) {
        setState(() {
          //     _ponyModel.type = value;
        });
        //    _showSnackBar('Type', value);
      },
    );
  }

}
