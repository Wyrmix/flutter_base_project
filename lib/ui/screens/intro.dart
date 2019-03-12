import 'dart:async';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/const.dart';
import 'package:flutter_base_project/di/graph.dart';
import 'package:flutter_base_project/ui/routes/sample_router.dart';
import 'package:flutter_politburo/di/graph.dart';
import 'package:flutter_politburo/ui/component/di_widget.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with ContainerConsumer {
  SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return IntroPage(
            () => prefs.setBool(PREF_KEY_USER_HAS_COMPLETED_ONBOARDING, true));
  }

  @override
  void initState() {
    super.initState();
    // we should really just check the auth repo but the way flutter works makes
    // that hard to do in a lifecycle callback so here's the manual check on a delay
    Timer(Duration(milliseconds: 10), () {
      _checkOnboarding();
    });
  }

  Future _checkOnboarding() async {
    prefs = await SharedPreferences.getInstance();

    var onboardingComplete =
        prefs.getBool(PREF_KEY_USER_HAS_COMPLETED_ONBOARDING) ?? false;
    var userLogedIn = prefs.getString(KEY_SAVED_AT) != null;
    Fimber.d(
        "checking prefs [completed onboarding $onboardingComplete] [user logged in $userLogedIn]");

    if (onboardingComplete) {
      if (userLogedIn) {
        Fimber.d('user logged in');
        SampleRouter().router.navigateTo(context, '/home', replace: true);
      } else {
        Fimber.d('user needs to logged in');
        SampleRouter().router.navigateTo(context, '/login', replace: true);
      }
    }
  }
}

class IntroPage extends StatelessWidget {
  final VoidCallback callback;

  IntroPage(this.callback);

  @override
  Widget build(BuildContext context) {
    final pages = [
      PageViewModel(
          pageColor: const Color(0xFF03A9F4),
          bubble: Image.asset('res/images/crane.png'),
          body: Text(
            'Buildaga is focused on contruction management software building tools tailored to your needs',
          ),
          title: Text(
            'Construction Focued',
          ),
          textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
          mainImage: Image.asset(
            'res/images/crane.png',
            height: 256.0,
            width: 256.0,
            alignment: Alignment.center,
          )),
      PageViewModel(
        pageColor: const Color(0xFF8BC34A),
        iconImageAssetPath: 'res/images/clipboard.png',
        body: Text(
          'Full projects can be managed with Buildaga including getting setup fast with our template feature',
        ),
        title: Text('Management & Templates'),
        mainImage: Image.asset(
          'res/images/clipboard.png',
          height: 256.0,
          width: 256.0,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      ),
      PageViewModel(
        pageColor: const Color(0xFF607D8B),
        iconImageAssetPath: 'res/images/cell_tower.png',
        body: Text(
          'Use our mobile app to handle management away from your office',
        ),
        title: Text('Mobile'),
        mainImage: Image.asset(
          'res/images/cell_tower.png',
          height: 256.0,
          width: 256.0,
          alignment: Alignment.center,
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white),
      ),
    ];

    return Scaffold(
      body: IntroViewsFlutter(
        pages,
        onTapDoneButton: () {
          callback();
          Navigator.pushNamed(context, '/login');
        },
        pageButtonTextStyles: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      endDrawer: SampleGraph.graph.debugDrawer,
    );
  }
}
