import 'package:flutter/material.dart';
import 'package:flutter_base_project/ui/nav.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:flutter_politburo/ui/scaffold/debug_drawer_scaffold_factory.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  ScaffoldFactory _scaffoldFactory;

  @override
  void initState() {
    super.initState();
    _scaffoldFactory = DebugDrawerScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: Nav.appColorPalette,
    );
    Nav.toolbarNoBottomNav(_scaffoldFactory);
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.appBar = _scaffoldFactory.buildAppBar(
        titleVisibility: true,
        leadingVisibility: false,
        tabBarVisibility: false,
        titleWidget: Text('Login'));
    return _scaffoldFactory.build(Container(
      child: Center(
        child: Text('Login'),
      ),
    ));
  }
}
