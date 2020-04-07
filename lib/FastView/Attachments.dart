import 'package:flutter/material.dart';

class Attachments extends StatefulWidget {
  final Function changeIsAttachments;

  const Attachments({Key key, this.changeIsAttachments}) : super(key: key);
  @override
  _AttachmentsState createState() => _AttachmentsState();
}

class _AttachmentsState extends State<Attachments> {
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
                      widget.changeIsAttachments();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(child: Container(),),
            
              Container(
                width: 295.93,
                height: 67.65,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    '+ UPLOAD',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  color: Color.fromRGBO(253, 244, 234, 1),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side: BorderSide(
                        color: Color.fromRGBO(253, 244, 234, 1),
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
