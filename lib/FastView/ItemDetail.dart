import 'package:flutter/material.dart';

class ItemDetail extends StatefulWidget {
  final String goalTitle;
  final String todoTitle;
  final String endDate;
  final Function changeisCheckScreen;

  const ItemDetail(
      {Key key,
      this.goalTitle,
      this.todoTitle,
      this.endDate,
      this.changeisCheckScreen})
      : super(key: key);

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
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
                      widget.changeisCheckScreen(
                          widget.endDate, widget.goalTitle, widget.todoTitle);
                    },
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    widget.goalTitle,
                    style: TextStyle(fontSize: 40),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text("31%", style: TextStyle(fontSize: 30))
                ],
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("END AT " + widget.endDate,
                      style: TextStyle(fontSize: 15))),
              SizedBox(
                height: 24,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Text(widget.todoTitle, style: TextStyle(fontSize: 15))),
              SizedBox(
                height: 32,
              ),
              Text("21%", style: TextStyle(fontSize: 70)),
              Expanded(
                child: Container(),
              ),
              Container(
                width: 295.93,
                height: 67.65,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  color: Color.fromRGBO(122, 205, 198, 1),
                  onPressed: () {
                    widget.changeisCheckScreen(
                        widget.endDate, widget.goalTitle, widget.todoTitle);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side:
                          BorderSide(color: Color.fromRGBO(122, 205, 198, 1))),
                ),
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ));
  }
}
