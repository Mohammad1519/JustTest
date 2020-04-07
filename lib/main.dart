import 'dart:async';

import 'package:aimify/HomePage.dart';
import 'package:aimify/services/auth/AuthService.dart';
import 'package:flutter/material.dart';
import './introScreen.dart';
import './initalHome.dart';
import 'AuthenticationState.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final StreamController<AuthenticationState> _streamController =
  new StreamController<AuthenticationState>.broadcast();

  AuthService _authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Initial Commit',
      theme: ThemeData(fontFamily: 'FlatIcon'),
      home: InitalHome(_streamController,_authService),
      routes: {
        '/HomePage': (context) => HomePage(_streamController,_authService),
        '/InitalHome': (context) => InitalHome(_streamController,_authService),
      },
    );
  }
}