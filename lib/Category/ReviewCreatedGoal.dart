import 'dart:convert';

import 'package:aimify/Category/AddTodo.dart';
import 'package:aimify/Category/Todo.dart';
import 'package:aimify/FastView/FastView.dart';
import 'package:aimify/FastView/GoalItem.dart';
import 'package:aimify/HomePage.dart';
import 'package:flutter/material.dart';

class ReviewCreatedGoal extends StatefulWidget {
  final String categoryTitle;
  final String subCategoryTitle;
  final String title;
  final String endDate;
  final String startDate;
  final Function changeTabCallback;

  const ReviewCreatedGoal(
      {Key key,
      this.categoryTitle,
      this.subCategoryTitle,
      this.title,
      this.endDate,
      this.startDate,
      this.changeTabCallback})
      : super(key: key);
  @override
  _ReviewCreatedGoalState createState() => _ReviewCreatedGoalState();
}

class _ReviewCreatedGoalState extends State<ReviewCreatedGoal> {
  void addTodoCallback(Todo todo) {
    setState(() {
      toDoList.add(todo);
    });
  }

  List<Todo> toDoList = List();
  Future<List<Todo>> _fetchToDos() async {
    //TODO fetch listItems from api
    String res = '[]';

    final items = jsonDecode(res).cast<Map<String, dynamic>>();
    List<Todo> todoItem = items.map<Todo>((json) {
      return Todo.fromJson(json);
    }).toList();
    return todoItem;
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchToDos().then((list) {
      setState(() {
        toDoList = list;
      });
    });
    super.initState();
  }

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  child: Text(
                    widget.categoryTitle ?? 'null',
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  child: Text(
                    widget.subCategoryTitle ?? 'null',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(85, 90, 111, 1)),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  child: Text(
                    widget.title ?? 'null',
                    style: TextStyle(fontSize: 40),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  child: Text(
                    "END AT " + widget.endDate ?? 'null',
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: toDoList
                      .map<Widget>((item) => Todo(
                            title: item.title,
                          ))
                      .toList(),
                ),
              ),
              // Todo(title: "Test",),
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
                   widget.changeTabCallback(1 , GoalItem(title: widget.title,endDate: widget.endDate,todoList: toDoList,));
                    Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName));
                  },
                  // onPressed: () {
                  //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  //         builder: (_) => HomePage()) , ModalRoute.withName("/HomePage"));
                  //   },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side:
                          BorderSide(color: Color.fromRGBO(122, 205, 198, 1))),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 32),
                width: 295.93,
                height: 67.65,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    '+ ADD YOUR TODOs',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  color: Color.fromRGBO(253, 244, 234, 1),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => AddTodo(
                              title: widget.title,
                              endDate: widget.endDate,
                              startDate: widget.startDate,
                              addTodoCallback: addTodoCallback)),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      side: BorderSide(
                        color: Color.fromRGBO(253, 244, 234, 1),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
