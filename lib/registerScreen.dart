import 'dart:async';

import 'package:aimify/HomePage.dart';
import 'package:aimify/services/auth/AuthService.dart';
import 'package:aimify/services/auth/OAuthWaiting.dart';
import 'package:aimify/services/auth/facebookWebView.dart';
import 'package:aimify/services/auth/oAuthDeepLInk.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'AuthenticationState.dart';

class RegisterScreen extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;
  const RegisterScreen(this._streamController, this._authService);
  @override
  _RegisterScreenState createState() => _RegisterScreenState(_streamController,this._authService);
}

class _RegisterScreenState extends State<RegisterScreen> {

  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  _RegisterScreenState(this._streamController,this._authService);
  signUp(String username) async {
    _streamController.add(AuthenticationState.codeSent());
  }

  @override
  void initState() {
    print("in init state 1111111");
    _streamController.add(AuthenticationState.appOpened());
    _setIsFirst();
    super.initState();
  }

  Future<bool> _setIsFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirst', false);
    return true;
  }

  Future<bool> _setxAuthId(String xAuthId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('xAuthId', xAuthId);
    return true;
  }

  TextEditingController userNameTextFieldController = new TextEditingController();
  TextEditingController nameTextFieldController = new TextEditingController();

  Future<Null> handleGoogleOAuth() async {
    _authService.launchGoogleOauthURL();
    print("why ,,,,, ");
    getUriLinksStream().listen((Uri uri) async {
      print("the linke is :::: " + uri.path);
      print("the linke is :::: " + uri.queryParameters.toString());
      print("the linke is :::: " + uri.host);

      AuthApiResponseModel authResponse = await _authService.authenticate(uri.queryParameters["xAuthId"]);

      print("the auth response ::: " + authResponse.userInfo.name);

      _streamController.add(AuthenticationState.authenticated(xAuthId: uri.queryParameters["xAuthId"],
          userInfo: authResponse.userInfo));
      _setxAuthId(uri.queryParameters["xAuthId"]);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomePage(_streamController,_authService)),
      );
      closeWebView();
      // Parse the link and warn the user, if it is not correct
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 64),
                    child: Image.asset(
                      'assets/img1.png',
                      width: 150,
                    ),
                  ),
                  Align(
                    child: Text('ENTER EMAIL TO START FIRST GOAL'),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: TextField(
                        style: TextStyle(fontSize: 22.0),
                      controller: userNameTextFieldController,
                        decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                      border: InputBorder.none,
                      hintText: 'type here ...',
                    )),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                    child: Text('YOUR NAME'),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: TextField(
                        style: TextStyle(fontSize: 22.0),
                      controller: nameTextFieldController,
                        decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                      hintText: 'type here ...',
                    )),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                      width: 295.93,
                    height: 67.65,
                    child: RaisedButton(
                      child: Text(
                        'START',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Color.fromRGBO(122, 205, 198, 1),
                      onPressed: () {
                        Stream.fromFuture(
                            _authService.signUp(userNameTextFieldController.text.trim(), nameTextFieldController.text.trim()).then((signUpRes) {
                              if(signUpRes != null){
                                setState(() {
                                  _streamController.add(AuthenticationState.codeSent(xAuthId: signUpRes.userInfo.xAuthId,
                                      userInfo: UserInfoModel(username: userNameTextFieldController.text.trim(),name:nameTextFieldController.text.trim())));
                                  _setxAuthId(signUpRes.userInfo.xAuthId);
                                });
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => HomePage(_streamController,_authService)),
                                );
                              } else{
                                print("error calling signUp ..... ");
                                //TODO must show error
                              }
                            })
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          side: BorderSide(
                              color: Color.fromRGBO(122, 205, 198, 1))),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                    Text("or SIGN-IN WITH SOCIAL"),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                  ]),
                  Row(children: <Widget>[
                    InkWell(
                      onTap: () async {
                        await handleGoogleOAuth();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/google.png',
                              width: 50,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'GOOGLE',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: () {
                        _authService.launchFacebookOauthURL();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/facebook.png',
                              width: 50,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text('FACEBOOK', style: TextStyle(fontSize: 17)),
                          ],
                        ),
                      ),
                    )
                  ])
                ],
              ),
            )));
  }
}
