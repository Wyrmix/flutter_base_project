import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_project/const.dart';
import 'package:flutter_base_project/ui/screens/home.dart';
import 'package:flutter_base_project/ui/screens/intro.dart';
import 'package:flutter_base_project/ui/screens/login.dart';
import 'package:flutter_base_project/ui/screens/profile.dart';
import 'package:flutter_politburo/ui/routes/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SampleRouter extends AppRouter {
  static final SampleRouter _singleton = SampleRouter._internal();

  SampleRouter._internal() : super(new Router());

  factory SampleRouter() => _singleton;

  @override
  Map<String, Handler> routeMap() {
    return {
      "/": rootHandler,
      "/home": homeFunctionHandler,
      "/intro": introRouteHandler,
      "/login": loginRouteHandler,
      "/profile": profileRouteHandler,
    };
  }
}

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var loginRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginScreen();
});

var introRouteHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  SharedPreferences.getInstance()
      .then((sp) => sp.setString(PREF_KEY_USER_HAS_COMPLETED_ONBOARDING, null));
  return IntroScreen();
});

var homeFunctionHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var profileRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ProfileScreen();
});
