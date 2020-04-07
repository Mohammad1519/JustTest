import 'package:flutter/material.dart';

class SyncCalendar extends StatefulWidget {
  @override
  _SyncCalendarState createState() => _SyncCalendarState();
}

class _SyncCalendarState extends State<SyncCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
            SizedBox(
              height: 24,
            ),
            Row(
              children: <Widget>[
                Image.asset("assets/calendar.png", width: 60),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    "Google Calendar",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Image.asset("assets/microsoft.png", width: 60),
                  Container(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Microsoft Calendar",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
