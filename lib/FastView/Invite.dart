import 'package:flutter/material.dart';

class Invite extends StatefulWidget {
  final Function changeIsInvite;
  final Function changeIsInviteFriend;

  const Invite({Key key, this.changeIsInvite, this.changeIsInviteFriend})
      : super(key: key);
  @override
  _InviteState createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      widget.changeIsInvite();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  child: Text(
                    'SEARCH',
                    style: TextStyle(fontSize: 18),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Container(
                color: Color.fromRGBO(234, 234, 234, 1),
                child: TextField(
                    decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                  hintText: 'type here ...',
                )),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: 295.93,
                height: 67.65,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    'INVITE WITH EMAIL',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Color.fromRGBO(122, 205, 198, 1),
                  onPressed: () {
                    widget.changeIsInvite();
                    widget.changeIsInviteFriend();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side: BorderSide(
                        color: Color.fromRGBO(122, 205, 198, 1),
                      )),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}
