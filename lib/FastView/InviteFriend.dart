import 'package:flutter/material.dart';

class InviteFriend extends StatefulWidget {
  final Function changeIsInviteFriend;
  final Function changeIsInvite;

  const InviteFriend({Key key, this.changeIsInviteFriend, this.changeIsInvite}) : super(key: key);
  @override
  _InviteFriendState createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        widget.changeIsInvite();
                        widget.changeIsInviteFriend();
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
                      "FRIEND's NAME",
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    child: Text(
                     "FRIEND's EMAIL",
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
                Align(alignment: Alignment.centerLeft, child: Text("MESSAGE")),
                SizedBox(
                  height: 4,
                ),
                Expanded(
                  child: Container(
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: TextField(
                        maxLines: 20,

                        // controller: titleController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          // hintText: 'type here ...',
                        )),
                  ),
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
                      'SEND',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    color: Color.fromRGBO(122, 205, 198, 1),
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side:
                            BorderSide(color: Color.fromRGBO(122, 205, 198, 1))),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          )),
    );
  }
}
