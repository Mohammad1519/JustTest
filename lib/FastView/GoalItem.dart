import 'package:aimify/Category/Todo.dart';
import 'package:flutter/material.dart';

import 'ItemDetail.dart';

class GoalItem extends StatefulWidget {
  final String title;
  final String endDate;
  final String percent;
  final Function changeisCheckScreen;
  final Function changeIsAddNote;
  final Function changeIsInvite;
  final Function changeIsAttachments;
  final Function changeIsInviteFriend;

  final List<Todo> todoList;

  const GoalItem(
      {Key key,
      this.title,
      this.endDate,
      this.percent,
      this.todoList,
      this.changeisCheckScreen, this.changeIsAddNote, this.changeIsAttachments, this.changeIsInvite, this.changeIsInviteFriend})
      : super(key: key);
  @override
  _GoalItemState createState() => _GoalItemState();
}

class _GoalItemState extends State<GoalItem> {
  bool isExpanded = true;

  List<Widget> makeCustomToDoList(List<Todo> todoList, bool showMore) {
    List<Widget> widgets = List();

    for (var i = 0; i < todoList.length; i++) {
      if (showMore) {
        if (i >= 3) break;
      }
      widgets.add(Row(
        children: <Widget>[
          Column(
            children: <Widget>[Text(todoList[i].title), Text("21%")],
          ),
          Expanded(
            child: Container(),
          ),
          ButtonTheme(
            height: 31.22,
            minWidth: 100.54,
            child: RaisedButton(
              elevation: 10,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'CHECK',
                style: TextStyle(color: Colors.white),
              ),
              color: Color.fromRGBO(122, 204, 198, 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: () {
                //  Navigator.of(context).push(
                //         MaterialPageRoute(
                //             builder: (_) => ItemDetail(endDate: widget.endDate , goalTitle: widget.title,todoTitle: todoList[i].title,)),
                //       );
                widget.changeisCheckScreen(
                    widget.endDate, widget.title, todoList[i].title);
              },
            ),
          ),
        ],
      ));
    }
    return widgets;
  }

void choiceAction(String choice) {
  if (choice == Constants.EDIT) {
    print('I First Item');
  } else if (choice == Constants.NOTE) {
    widget.changeIsAddNote();
  } else if (choice == Constants.ATTACHMENT) {
    widget.changeIsAttachments();
  } else if (choice == Constants.INVITE) {
    widget.changeIsInvite();
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(widget.title, style: TextStyle(fontSize: 40)),
              Expanded(
                child: Container(),
              ),
              // IconButton(

              //   icon: Icon(Icons.more_horiz),
              //   color: Colors.black,
              //   onPressed: () {

              //   },
              // ),
              PopupMenuButton<String>(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                icon: Icon(Icons.more_horiz),
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice,
                          style:
                              TextStyle(decoration: TextDecoration.underline)),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "END AT " + widget.endDate,
                style: TextStyle(fontSize: 15),
              )),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "32%",
                style: TextStyle(fontSize: 30),
              )),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: makeCustomToDoList(widget.todoList, isExpanded),
            ),
          ),
          widget.todoList.length > 3
              ? InkWell(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(!isExpanded ? "Show Less" : "Show More"))
              : Container(),
          Divider(color: Colors.black45)
        ],
      ),
    );
  }
}

class Constants {
  static const String EDIT = 'EDIT';
  static const String NOTE = 'NOTE';
  static const String ATTACHMENT = 'ATTACHMENT';
  static const String INVITE = 'INVITE';

  static const List<String> choices = <String>[EDIT, NOTE, ATTACHMENT, INVITE];
}
