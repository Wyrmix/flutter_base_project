import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class Nav {
  static toolbarNoBottomNav(ScaffoldFactory factory) {
    factory.appBarVisibility = true;
    factory.nestedAppBarVisibility = false;
    factory.drawerVisibility = false;
    factory.bottomNavigationBarVisibility = false;
  }

  static bottomAppBarNoToolbar(ScaffoldFactory factory) {
    factory.appBarVisibility = false;
    factory.nestedAppBarVisibility = false;
    factory.drawerVisibility = false;
    factory.bottomNavigationBarVisibility = true;
    factory.backgroundType = BackgroundType.normal;

    _bottomAppBar(factory);
  }

  static bottomAppBarWithToolbar(ScaffoldFactory factory) {
    factory.appBarVisibility = false;
    factory.nestedAppBarVisibility = false;
    factory.drawerVisibility = false;
    factory.bottomNavigationBarVisibility = true;

    _bottomAppBar(factory);
  }

  static _bottomAppBar(ScaffoldFactory factory) {
    factory.floatingActionButtonVisibility = true;
    factory.bottomNavigationBarVisibility = true;
  }

  static MaterialPalette appColorPalette = MaterialPalette(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.lightBlueAccent,
      darkPrimaryColor: Colors.orange[900],
      dividerColor: Colors.black,
      lightPrimaryColor: Colors.orangeAccent,
      secondaryColor: Colors.lightBlue,
      iconColor: Colors.white,
      secondaryTextColor: Colors.black26,
      textColor: Colors.black);

  static Future<bool> onWillPop(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          );
        }) ??
        false;
  }
}

mixin SimpleWillPop<T extends StatefulWidget> on State<T> {
  Future<bool> onWillPop() => Nav.onWillPop(context);
}
