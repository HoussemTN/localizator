import 'package:flutter/material.dart';

class FavoriteLocationDropDown extends StatefulWidget {
  FavoriteLocationDropDown({Key key}) : super(key: key);
  static String currentImage;

  @override
  createState() => FavoriteLocationDropDownState();
}

class FavoriteLocationDropDownState extends State<FavoriteLocationDropDown> {
  final Map<int, String> favoriteLocationImage = {
    0: "images/searchLocation.png",
    1: "images/house.png"
  };
  List<DropdownMenuItem<String>> _dropDownMenuItems;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    FavoriteLocationDropDown.currentImage = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String image in favoriteLocationImage.values) {
      items.add(new DropdownMenuItem(
        value: image,
        child: Wrap(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
          ],
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(12.0),
      width: 100.0,
      color: Colors.white,
      child: new Center(
          child: new Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Container(),
          new DropdownButton(
            value: FavoriteLocationDropDown.currentImage,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          )
        ],
      )),
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      FavoriteLocationDropDown.currentImage = selectedCity;
    });
  }
}
