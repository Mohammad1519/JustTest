import 'dart:async';
import 'dart:io';

import 'package:aimify/services/auth/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:url_launcher/url_launcher.dart';

import '../../AuthenticationState.dart';
import '../../HomePage.dart';

// ...


StreamSubscription _sub;

Future<Null> initUniLinks(StreamController<AuthenticationState> _streamController, AuthService _authService,BuildContext context) async {
  // ... check initialLink

  // Attach a listener to the stream
  _sub = getLinksStream().listen((String link) {
    print("the linke is :::: " + link);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomePage(_streamController,_authService)),
    );

    closeWebView();
    // Parse the link and warn the user, if it is not correct
  }, onError: (err) {
    // Handle exception by warning the user their action did not succeed
  });

  // NOTE: Don't forget to call _sub.cancel() in dispose()
}


