import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';




class UserInfoModel {
  final String username;
  final String name;
  final int userCreationTime;
  final String xAuthId;
  final String bio;
  final String gender;

  UserInfoModel({this.username, this.name, this.userCreationTime, this.xAuthId, this.bio, this.gender});

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      username: json['username'],
      name: json['name'],
      userCreationTime: json['userCreationTime'],
      xAuthId: json['xAuthId'],
      bio: json['bio'],
      gender: json['gender'],
    );
  }
}

class AuthApiResponseModel {
  final int statusCode;
  final String message;
  final UserInfoModel userInfo;

  AuthApiResponseModel({this.statusCode, this.message, this.userInfo});

  factory AuthApiResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthApiResponseModel(
      statusCode: json['statusCode'],
      message: json['message'],
      userInfo: UserInfoModel.fromJson(json['userInfo']),
    );
  }
}


class AuthService {

  Future<AuthApiResponseModel> authenticate(String xAuthId) async {
    try{
      String url = "https://m5hapq2267.execute-api.eu-west-1.amazonaws.com/Prod/auth/clientAuthenticate";
      http.Response response = await http.get(url,headers: {'x-auth-id': xAuthId}).timeout(Duration(seconds: 50),);
      if(response.statusCode == HttpStatus.ok){
        print("it is in if ------------ ");
        return AuthApiResponseModel.fromJson(json.decode(response.body));
      } else {
        print("in else "+ response.statusCode.toString());
        null;
      }
    } on Exception catch(e){
      print("exception" + e.toString());
      return null;
    }
  }

  Future<bool> completeProfile(String xAuthId , String newName, String newEmail, String newGender, String about) async {
    try{
      String url = "https://m5hapq2267.execute-api.eu-west-1.amazonaws.com/Prod/auth/completeProfile";
      Map<String, String> headers = {"Content-type": "application/json",'x-auth-id': xAuthId};
      String jsonBody = json.encode({"email": newEmail , "name": newName, "gender": newGender, "about": about});
      http.Response response = await http.put(url,headers: headers, body: jsonBody).timeout(Duration(seconds: 50),);
      print("the cmp res :::: " + response.body);
      print("the cmp status :::: " + response.statusCode.toString());
      return response.statusCode == HttpStatus.ok;
    } on Exception catch(e){
      print("exception" + e.toString());
      return false;
    }
  }

  Future<AuthApiResponseModel> signUp(String username, String name) async {
    String url = "https://m5hapq2267.execute-api.eu-west-1.amazonaws.com/Prod/auth/signUp";
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = json.encode({"email": username , "name": name});
    try{
      http.Response response = await http.post(url,headers: headers ,body: jsonBody).timeout(Duration(seconds: 10),);
      print("the sign up res ::: " + response.body);
      if(response.statusCode == HttpStatus.ok){
        print("it is in if ------------ ");
        return AuthApiResponseModel.fromJson(json.decode(response.body));
      } else {
        print("in else "+ response.statusCode.toString());
        null;
      }
    } on Exception catch(e){
      print("exception" + e.toString());
      return null;
    }

  }

  launchGoogleOauthURL() async {
    const url = 'https://m5hapq2267.execute-api.eu-west-1.amazonaws.com/Prod/auth/google/getAuthUrl';
    try{
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } on Exception{
      print("what the fuck ....... " + url);
    }
  }

  launchFacebookOauthURL() async {
    const url = 'https://m5hapq2267.execute-api.eu-west-1.amazonaws.com/Prod/auth/facebook/getAuthUrl';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }


}



