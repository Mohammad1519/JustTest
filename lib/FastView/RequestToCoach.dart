import 'package:flutter/material.dart';

class RequestToCoach extends StatefulWidget {
  @override
  _RequestToCoachState createState() => _RequestToCoachState();
}

class _RequestToCoachState extends State<RequestToCoach> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: ButtonTheme(
                  height: 31.22,
                  minWidth: 100.54,
                  child: RaisedButton(
                    elevation: 10,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text('back'),
                    color: Color.fromRGBO(253, 244, 234, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
