import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  final String title ;
  const Todo({Key key, this.title})
      : super(key: key);
       factory Todo.fromJson(Map<String, dynamic> parsedJson) {
    return Todo(
      title: parsedJson['title'],
 
    );
  }
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(widget.title , style: TextStyle(color: Colors.black),),
          Expanded(
            child: Container(),
          ),
          IconButton(
            icon: Icon(Icons.more_horiz),
            color: Colors.black,
            onPressed: () {
            },
          )
        ],
      ),
    );
  }
}
