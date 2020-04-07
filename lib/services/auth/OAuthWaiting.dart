import 'dart:async';

import 'package:aimify/HomePage.dart';
import 'package:aimify/registerScreen.dart';
import 'package:aimify/services/auth/AuthService.dart';
import 'package:aimify/services/auth/oAuthDeepLInk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AuthenticationState.dart';

class OAuthWaiting extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;
  const OAuthWaiting(this._streamController,this._authService);
  @override
  _OAuthWaiting createState() => _OAuthWaiting(_streamController,_authService);
}

class _OAuthWaiting extends State<OAuthWaiting> {

  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;

  _OAuthWaiting(this._streamController, this._authService);


//  @override
//  void initState() {
//    print("in init state 1111111");
////    initUniLinks(_streamController, _authService,context);
//    _setCurrentAuthState();
//    super.initState();
//  }
//

//  getLinksStream().listen((String link) {
//  print("the linke is :::: " + link);
//
//  Navigator.of(context).push(
//  MaterialPageRoute(builder: (context) => HomePage(_streamController,_authService)),
//  );
//
//  closeWebView();
//  // Parse the link and warn the user, if it is not correct
//  });

  @override
  void initState() {
    print("in init state 1111111");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("builded .... ");
    _authService.launchGoogleOauthURL();
    var s = getLinksStream();

    return StreamBuilder<String>(
        stream: s,
        builder: (BuildContext context,
            AsyncSnapshot<String> snapshot) {
          if(!snapshot.hasData){
            return LinearProgressIndicator();
          }


          final url = snapshot.data;
          print("here --------- " + url);
          closeWebView();
          return buildUi(url);

        });
  }

  Widget buildUi(String url) {
//    closeWebView();
    return HomePage(_streamController,_authService);
  }
}