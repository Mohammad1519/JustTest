import 'dart:async';

import 'package:aimify/registerScreen.dart';
import 'package:aimify/services/auth/AuthService.dart';
import 'package:aimify/services/auth/oAuthDeepLInk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthenticationState.dart';
import 'HomePage.dart';
import 'introScreen.dart';
class InitalHome extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;
  const InitalHome(this._streamController,this._authService);
  @override
  _InitalHomeState createState() => _InitalHomeState(_streamController,_authService);
}

class _InitalHomeState extends State<InitalHome> {

  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;

  _InitalHomeState(this._streamController, this._authService);

//  final StreamController<AuthenticationState> _streamController =
//  new StreamController<AuthenticationState>.broadcast();
//
//  AuthService _authService = new AuthService();


  Widget buildUi(BuildContext context, AuthenticationState authState) {
      if (authState.isAuthenticated) {
        _streamController.add(AuthenticationState.authenticated(xAuthId: authState.xAuthId, userInfo: authState.userInfo));
        return HomePage(_streamController,_authService);
      }
      else if(!authState.isAuthenticated && authState.xAuthId.isNotEmpty){
        _streamController.add(AuthenticationState.codeSent(xAuthId: authState.xAuthId, userInfo: authState.userInfo));
        return HomePage(_streamController,_authService);
      }
      else {
        return authState.isFirst ? OnBoardingPage(_streamController,_authService) : RegisterScreen(_streamController,_authService);
      }
    }


   _checkIsLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String xAuthId = prefs.getString('xAuthId') ?? '';
    if(xAuthId.isEmpty){
      _streamController.add(AuthenticationState.appOpened());
    } else {
      print(xAuthId);
      AuthApiResponseModel login =  await _authService.authenticate(xAuthId);
      if(login != null){
        _streamController.add(AuthenticationState.authenticated(xAuthId: login.userInfo.xAuthId, userInfo: login.userInfo));
      } else {
        _streamController.add(AuthenticationState.codeSent(xAuthId: xAuthId));
      }

    }
  }

  Future<AuthenticationState> _setCurrentAuthState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstFlag = prefs.getBool('isFirst') ?? true;
    AuthenticationState state = await _checkIsLoggedIn();
      isFirstFlag ? _streamController.add(AuthenticationState.initial()) : state;
  }

  @override
  void initState() {
    print("in init state 1111111");
//    initUniLinks(_streamController, _authService,context);
    _setCurrentAuthState();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return new StreamBuilder<AuthenticationState>(
        stream: _streamController.stream,
        builder: (BuildContext context,
            AsyncSnapshot<AuthenticationState> snapshot) {
          if(!snapshot.hasData){
            return LinearProgressIndicator();
          }

            final authState = snapshot.data;
            return buildUi(context, authState);

        });
  }
}