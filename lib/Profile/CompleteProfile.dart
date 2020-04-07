import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aimify/AuthenticationState.dart';
import 'package:aimify/HomePage.dart';
import 'package:aimify/services/auth/AuthService.dart';
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfile extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;
  CompleteProfile(this._streamController, this._authService);
  @override
  _CompleteProfileState createState() =>
      _CompleteProfileState(_streamController, _authService);
}

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  void initState() {
    super.initState();
    getProfileImage();
  }

  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;

  var selectGenderItem = 0;
  List<String> genderList = <String>["Male", "Female", "Other"];

  bool isCoach = false;
  bool preUserInfoSet = false;
  String imageBase64;
  Uint8List bytes;

  _CompleteProfileState(this._streamController, this._authService);

  TextEditingController emailTextFieldController = new TextEditingController();
  TextEditingController aboutTextFieldController = new TextEditingController();
  TextEditingController nameTextFieldController = new TextEditingController();

  completeProfile(
      BuildContext ctx, String xAuthId, UserInfoModel userInfo) async {
//    if(xAuthId.isEmpty){
//      _streamController.add(AuthenticationState.appOpened());
//    } else{
//      _streamController.add(AuthenticationState.authenticated(xAuthId: xAuthId, userInfo: userInfo));
//    }
    var completeProfileRes = await _authService.completeProfile(
        xAuthId,
        nameTextFieldController.text.trim(),
        emailTextFieldController.text.trim(),
        genderList[selectGenderItem],
        aboutTextFieldController.text.trim());
    if (completeProfileRes != null && completeProfileRes) {
      print("we are hrere ............");
//        AuthApiResponseModel newUserINfo = await _authService.authenticate(xAuthId);
//        _streamController.add(AuthenticationState.authenticated(xAuthId: xAuthId , userInfo: newUserINfo.userInfo));
//        print("the userINfo name :::: " + newUserINfo.userInfo.name);
      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
            builder: (context) => HomePage(_streamController, _authService)),
      );
      //TODO return success res .....
    } else {
      _streamController.add(AuthenticationState.appOpened());
      print("error calling signUp ...... ");
      //TODO must show error
    }

    return completeProfileRes;
  }

  File _pickedImage;

  void _pickImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        uplaodProfileImage(prefs.get('xAuthId'), file);

        setState(() => _pickedImage = file);
      }
    }
  }

  Future<bool> uplaodProfileImage(String xAuthId, File _image) async {
    try {
      String base64Image = base64Encode(_image.readAsBytesSync());
      String url =
          "https://m5hapq2267.execute-api.eu-west-1.amazonaws.com/Prod/auth/profilePicture";
      Map<String, String> headers = {
        "Content-type": "application/json",
        'x-auth-id': xAuthId
      };
      String jsonBody = json.encode({"image": base64Image});
      http.Response response =
          await http.post(url, headers: headers, body: jsonBody).timeout(
                Duration(seconds: 50),
              );
      print("upload Res ====== " + response.body);
      print("status :::: " + response.statusCode.toString());
      return response.statusCode == HttpStatus.ok;
    } on Exception catch (e) {
      print("exception" + e.toString());
      return false;
    }
  }

  Future<String> getProfileImage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String url =
          "https://m5hapq2267.execute-api.eu-west-1.amazonaws.com/Prod/auth/profilePicture";
      Map<String, String> headers = {
        "Content-type": "application/json",
        'x-auth-id': prefs.get("xAuthId")
      };
      http.Response response = await http.get(url, headers: headers);

      print("get Res ====== " + response.body);
      print("status :::: " + response.statusCode.toString());
      setState(() {
        imageBase64 = response.body;
        bytes = base64Decode(response.body);
      });
      return response.body;
    } on Exception catch (e) {
      print("exception" + e.toString());
      return e.toString();
    }
  }

  Widget buildUi(BuildContext context, AuthenticationState authState) {
    if (!preUserInfoSet && authState.userInfo != null) {
      if (authState.userInfo.name != null &&
          authState.userInfo.name.isNotEmpty) {
        print("name is not nullll :::: ");
        nameTextFieldController.text = authState.userInfo.name;
      }
      if (authState.userInfo.username != null &&
          authState.userInfo.username.isNotEmpty) {
        print("username is not nullll :::: ");
        emailTextFieldController.text = authState.userInfo.username;
      }

      if (authState.userInfo.gender != null &&
          authState.userInfo.gender.isNotEmpty) {
        print("username is not nullll :::: ");
        selectGenderItem = genderList.indexOf(authState.userInfo.gender);
      }

      if (authState.userInfo.bio != null && authState.userInfo.bio.isNotEmpty) {
        print("username is not nullll :::: ");
        aboutTextFieldController.text = authState.userInfo.bio;
      }

      switch (authState.isAuthenticated) {
        case (true):
          print("it is true .......  --------------");
          _streamController.add(AuthenticationState.authenticated(
              xAuthId: authState.xAuthId, userInfo: authState.userInfo));
          break;
        default:
          _streamController.add(AuthenticationState.codeSent(
              xAuthId: authState.xAuthId, userInfo: authState.userInfo));
      }
      preUserInfoSet = true;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 78,
                  ),
                  Center(
                    child: _pickedImage == null
                        ? ButtonTheme(
                            padding: EdgeInsets.symmetric(vertical: 1),
                            minWidth: 200.0,
                            height: 150.0,
                            child: RaisedButton(
                              child: Container(
                                alignment: Alignment.center,
                                width: 108,
                                height: 38,
                                child: Text(
                                  'UPLOAD',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100),
                                ),
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: null,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                        color: Colors.black, width: 0.5)),
                              ),
                              color: Colors.white,
                              onPressed: _pickImage,
                              shape: CircleBorder(
                                side:
                                    BorderSide(color: Colors.black, width: 0.5),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: _pickImage,
                            child: Container(
                              height: 160.0,
                              width: 160.0,
                              decoration: new BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: new DecorationImage(
                                  image: FileImage(_pickedImage),
                                  fit: BoxFit.cover,
                                ),
                                border:
                                    Border.all(color: Colors.white, width: 1.0),
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(80.0)),
                              ),
                            )),
                  ),
                  SizedBox(
                    height: 23,
                  ),
                  Align(
                    child: Text(
                      'YOUR NAME',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 80,
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: TextField(
                        style: TextStyle(fontSize: 22.0),
                        controller: nameTextFieldController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 25),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 23,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                          hintText: 'type here ...',
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    child: Text(
                      'YOUR EMAIL',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 80,
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: TextField(
                        style: TextStyle(fontSize: 22.0),
                        controller: emailTextFieldController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 25),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 23,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                          hintText: 'type here ...',
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    child: Text(
                      'GENDER',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 80,
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: CupertinoPicker(
                      children: <Widget>[
                        MaterialButton(
                          child: Text(
                            "Male",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          color: Colors.redAccent,
                        ),
                        MaterialButton(
                          child: Text(
                            "Female",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          color: Colors.redAccent,
                        ),
                        MaterialButton(
                          child: Text(
                            "Other",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          color: Colors.indigo,
                        ),
                      ],

                      itemExtent: 35, //height of each item
                      looping: true,
                      onSelectedItemChanged: (int index) {
                        print("index ................. " + index.toString());
                        selectGenderItem = index;
                      },
//                        controller: genderTextFieldController,
//                        decoration: InputDecoration(
//                          border: InputBorder.none,
//                          contentPadding:
//                          EdgeInsets.symmetric(horizontal: 12, vertical: 25),
//                          hintStyle: TextStyle(fontSize: 23, color: Colors.black54,fontWeight: FontWeight.normal ),
//                          hintText: 'type here ...',
//                        )
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    child: Text(
                      'ABOUT',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w100),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    height: 240,
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: TextField(
                        style: TextStyle(fontSize: 22.0),
                        controller: aboutTextFieldController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 30,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                              fontSize: 23,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 25),
                          hintStyle: TextStyle(
                              fontSize: 23,
                              color: Colors.black54,
                              fontWeight: FontWeight.normal),
                          hintText: 'type here ...',
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          child: Text(
                            'I\'M COACH',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w100),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Switch(
                          value: isCoach,
                          onChanged: (value) {
                            setState(() {
                              isCoach = value;
                            });
                          },
                          activeTrackColor: Color.fromRGBO(122, 205, 198, 1),
                          activeColor: Color.fromRGBO(122, 205, 198, 1),
                          inactiveTrackColor:
                              Color.fromRGBO(234, 234, 234, 0.5),
                          inactiveThumbColor: Color.fromRGBO(122, 205, 198, 1),
                        ),
                      ]),
                  SizedBox(
                    height: 26,
                  ),
                  ButtonTheme(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    minWidth: 330.0,
                    height: 85.0,
                    child: RaisedButton(
                      elevation: 3.5,
                      child: Text(
                        'CONNECT TO SOCIAL',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      color: Color.fromRGBO(122, 205, 198, 1),
                      onPressed: () {
                        print("the auth state value ::: " + authState.xAuthId);
                        completeProfile(
                            context, authState.xAuthId, authState.userInfo);
                        print(aboutTextFieldController.text);
                        print("connect to social pressed ....");
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        side: BorderSide(
                            color: Color.alphaBlend(
                                Color(0x78CCC6), Color(0x00000029))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthenticationState>(
        stream: _streamController.stream,
        builder: (BuildContext context,
            AsyncSnapshot<AuthenticationState> snapshot) {
          UserInfoModel userInfo;
          String userXAuthId;
          if (!snapshot.hasData) {
            _checkAuthentication();
            return LinearProgressIndicator();
          }

          return buildUi(context, snapshot.data);
        });
  }

  void _checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String xAuthId = prefs.getString('xAuthId') ?? '';
    if (xAuthId.isEmpty) {
      _streamController.add(AuthenticationState.appOpened());
    } else {
      print(xAuthId);
      AuthApiResponseModel login = await _authService.authenticate(xAuthId);
      if (login != null) {
        _streamController.add(AuthenticationState.authenticated(
            xAuthId: login.userInfo.xAuthId, userInfo: login.userInfo));
      } else {
        _streamController.add(AuthenticationState.codeSent(xAuthId: xAuthId));
      }
    }
  }
}
