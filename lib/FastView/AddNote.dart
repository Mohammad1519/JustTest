import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  final Function changeIsAddNote;

  const AddNote({Key key, this.changeIsAddNote}) : super(key: key);
  @override
  _AddNote createState() => _AddNote();
}

class _AddNote extends State<AddNote> {
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
                      widget.changeIsAddNote();
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(alignment: Alignment.centerLeft, child: Text("NOTE")),
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
              SizedBox(height: 16,),
            
              Container(
                width: 295.93,
                height: 67.65,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Color.fromRGBO(122, 205, 198, 1),
                  onPressed: () {
                    widget.changeIsAddNote();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side: BorderSide(
                          color: Color.fromRGBO(122, 205, 198, 1))),
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
