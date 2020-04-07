


import 'package:aimify/services/auth/AuthService.dart';

class AuthenticationState {
  final bool isAuthenticated;
  final bool isFirst;
  final String xAuthId;
  final UserInfoModel userInfo;


  AuthenticationState.initial({this.isAuthenticated = false, this.isFirst=true, this.xAuthId = '' , this.userInfo = null});

  AuthenticationState.appOpened({this.isAuthenticated = false, this.isFirst=false, this.xAuthId = '', this.userInfo = null});

  AuthenticationState.authenticated({this.isAuthenticated = true, this.isFirst=false, this.xAuthId = '', this.userInfo});

  AuthenticationState.codeSent({this.isAuthenticated = false, this.isFirst=false, this.xAuthId , this.userInfo});

  AuthenticationState.failed({this.isAuthenticated = false, this.isFirst=false, this.xAuthId = '', this.userInfo = null});

  AuthenticationState.signedOut({this.isAuthenticated = false, this.isFirst=false, this.xAuthId = '', this.userInfo = null});
}


