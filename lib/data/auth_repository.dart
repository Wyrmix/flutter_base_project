import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_base_project/const.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiver/core.dart';

import 'package:shared_preferences/shared_preferences.dart';

/// Handles firebase auth with multiple identification providers. Once an API token is retrieved
/// this class handles saving it to secure storage on each platform.
class AuthRepository {
  /// [googleSignIn] Google authentication client needed for firebase auth
  final GoogleSignIn _googleSignIn;

  /// [auth] Firebase auth that handles all identification providers
  final FirebaseAuth _auth;

  /// [keystore] the platform specific keystore implementation to handle saving an API token
  final FlutterSecureStorage _keystore;

  /// [prefs] a wrapper for platform specific key, value storage implementation
  final SharedPreferences _prefs;

  AuthRepository(this._googleSignIn, this._auth, this._keystore, this._prefs);

  Future<Optional<FirebaseUser>> loginWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseUser user = await _auth.signInWithCredential(credential);
      print("signed in " + user.displayName);
      final token = await user.getIdToken(refresh: true);
      await _keystore.write(key: API_TOKEN, value: token);
      await _prefs.setString(KEY_SAVED_AT, DateTime.now().toIso8601String());
      return Optional.of(user);
    } catch (e, stacktrace) {
      Fimber.e("error loging in $e", stacktrace: stacktrace);
    }
    return Optional.absent();
  }

  Future<Optional<FirebaseUser>> loginWithFacebook(String fbToken) async {
    try {
      var credential = FacebookAuthProvider.getCredential(accessToken: fbToken);
      FirebaseUser user = await _auth.signInWithCredential(credential);
      print("signed in " + user.displayName);
      final token = await user.getIdToken(refresh: true);
      await _keystore.write(key: API_TOKEN, value: token);
      await _prefs.setString(KEY_SAVED_AT, DateTime.now().toIso8601String());
      return Optional.of(user);
    } catch (e, stacktrace) {
      Fimber.e("error loging in $e", stacktrace: stacktrace);
    }
    return Optional.absent();
  }

  Future<Optional<FirebaseUser>> login(String username, String password) async {
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: username, password: password);
      print("signed in " + user.displayName);
      final token = await user.getIdToken(refresh: true);
      _keystore.write(key: API_TOKEN, value: token);
      await _prefs.setString(KEY_SAVED_AT, DateTime.now().toIso8601String());
      return Optional.of(user);
    } catch (e, stacktrace) {
      Fimber.e("error loging in $e", stacktrace: stacktrace);
    }
    return Optional.absent();
  }

  Future<Optional<FirebaseUser>> createAccount(
      String username, String password) async {
    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );
      print("signed in " + user.displayName);
      final token = await user.getIdToken(refresh: true);
      await _keystore.write(key: API_TOKEN, value: token);
      await _prefs.setString(KEY_SAVED_AT, DateTime.now().toIso8601String());
      return Optional.of(user);
    } catch (e, stacktrace) {
      Fimber.e("error loging in $e", stacktrace: stacktrace);
    }
    return Optional.absent();
  }

  Future<String> refreshToken() async {
    var user = await _auth.currentUser();
    if (user != null) {
      final token = await user.getIdToken(refresh: true);
      await _keystore.write(key: API_TOKEN, value: token);
      await _prefs.setString(KEY_SAVED_AT, DateTime.now().toIso8601String());
    }
    return await getToken();
  }

  Future<String> getToken() async {
    return _keystore.read(key: API_TOKEN);
  }
}
