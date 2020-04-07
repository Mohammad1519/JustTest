import 'package:aimify/Category/ReviewCreatedGoal.dart';
import 'package:aimify/Category/SyncCalendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Todo.dart';

class AddTodo extends StatefulWidget {
  final String title;
  final String endDate;
  final String startDate;
  final Function addTodoCallback;

  const AddTodo(
      {Key key, this.title, this.endDate, this.startDate, this.addTodoCallback})
      : super(key: key);
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  DateTime days;
  final titleController = TextEditingController();
  String startDatePickerString;
  String endDatePickerString;
  DateTime startTime;
  DateTime endTime;
  String allDaysString;
  int _radioValue = 1;
  bool _switchSyncCalendar = false;
  bool _switchPublic = false;
  bool _switchNotification = false;
  bool _switchReschedule = false;
  bool partOfDay = false;

  void _switchSyncCalendarChange(bool value) {
    setState(() {
      _switchSyncCalendar = value;
    });
    if (value) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => SyncCalendar()),
      );
    }
  }

  void _switchPublicChange(bool value) {
    setState(() {
      _switchPublic = value;
    });
  }

  void _switchNotificationChange(bool value) {
    setState(() {
      _switchNotification = value;
    });
  }

  void _switchRescheduleChange(bool value) {
    setState(() {
      _switchReschedule = value;
    });
  }

  void _radioChange(int value) {
    setState(() {
      _radioValue = value;
    });
    if (value == 2) {
      setState(() {
        partOfDay = true;
      });
    } else {
      setState(() {
        partOfDay = false;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void initState() {
    startDatePickerString = widget.startDate;
    endDatePickerString = widget.endDate;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
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
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
              child: Column(
                children: <Widget>[
                  Align(
                    child: Text('TITLE'),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    color: Color.fromRGBO(234, 234, 234, 1),
                    child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 21),
                          border: InputBorder.none,
                          hintText: 'type here ...',
                        )),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                    child: Text('START DATE'),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height /
                                    3,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (date) {
                                    setState(() {
                                      startDatePickerString =
                                          DateFormat('dd-MMM-yyyy')
                                              .format(date);
                                    });
                                  },
                                ));
                          });
                    },
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(234, 234, 234, 1),
                        ),
                        child: Text(startDatePickerString)),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                    child: Text('END DATE'),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height /
                                    3,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (date) {
                                    setState(() {
                                      endDatePickerString =
                                          DateFormat('dd-MMM-yyyy')
                                              .format(date);
                                    });
                                  },
                                ));
                          });
                    },
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(234, 234, 234, 1),
                        ),
                        child: Text(endDatePickerString)),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                    child: Text('DAYs'),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext builder) {
                            return Container(
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height /
                                    3,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (date) {
                                          days = date;
                                        },
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: DateTime.now(),
                                      ),
                                    ),
                                    RaisedButton(
                                      child: Text("ADD DAY"),
                                      onPressed: () {
                                        setState(() {
                                          if (allDaysString == null) {
                                            allDaysString =
                                                DateFormat('dd-MMM-yyyy')
                                                    .format(days);
                                          } else {
                                            allDaysString += " , ";
                                            allDaysString +=
                                                DateFormat('dd-MMM-yyyy')
                                                    .format(days);
                                          }
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ));
                          });
                    },
                    child: Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(234, 234, 234, 1),
                        ),
                        child: Text(
                          allDaysString ?? ' ',
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Radio(
                              activeColor: Color.fromRGBO(122, 205, 198, 1),
                              groupValue: _radioValue,
                              onChanged: _radioChange,
                              value: 1,
                            ),
                            Text("all Day")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                              activeColor: Color.fromRGBO(122, 205, 198, 1),
                              groupValue: _radioValue,
                              onChanged: _radioChange,
                              value: 2,
                            ),
                            Text("part of Day")
                          ],
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: partOfDay,
                    child: Column(
                      children: <Widget>[
                        Align(
                          child: Text('START TIME'),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height /
                                          3,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
                                        onDateTimeChanged: (time) {
                                          setState(() {
                                            startTime = time ?? 'Type Here ...';
                                          });
                                        },
                                      ));
                                });
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 21),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(234, 234, 234, 1),
                              ),
                              child: Text(startTime.toString())),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Align(
                          child: Text('END TIME'),
                          alignment: Alignment.centerLeft,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext builder) {
                                  return Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height /
                                          3,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.time,
                                        onDateTimeChanged: (time) {
                                          setState(() {
                                            endTime = time ?? 'Type Here ...';
                                          });
                                        },
                                      ));
                                });
                          },
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 21),
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(234, 234, 234, 1),
                              ),
                              child: Text(endTime.toString())),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text("SYNC CALENDAR"),
                      Expanded(
                        child: Container(),
                      ),
                      Switch(
                        value: _switchSyncCalendar,
                        onChanged: _switchSyncCalendarChange,
                        activeTrackColor: Color.fromRGBO(122, 205, 198, 1),
                        activeColor: Color.fromRGBO(122, 205, 198, 1),
                        inactiveTrackColor: Color.fromRGBO(234, 234, 234, 0.5),
                        inactiveThumbColor: Color.fromRGBO(122, 205, 198, 1),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("PUBLIC"),
                      Expanded(
                        child: Container(),
                      ),
                      Switch(
                        value: _switchPublic,
                        onChanged: _switchPublicChange,
                        activeTrackColor: Color.fromRGBO(122, 205, 198, 1),
                        activeColor: Color.fromRGBO(122, 205, 198, 1),
                        inactiveTrackColor: Color.fromRGBO(234, 234, 234, 0.5),
                        inactiveThumbColor: Color.fromRGBO(122, 205, 198, 1),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("NOTIFICATION"),
                      Expanded(
                        child: Container(),
                      ),
                      Switch(
                        value: _switchNotification,
                        onChanged: _switchNotificationChange,
                        activeTrackColor: Color.fromRGBO(122, 205, 198, 1),
                        activeColor: Color.fromRGBO(122, 205, 198, 1),
                        inactiveTrackColor: Color.fromRGBO(234, 234, 234, 0.5),
                        inactiveThumbColor: Color.fromRGBO(122, 205, 198, 1),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("RESCHEDULE"),
                      Expanded(
                        child: Container(),
                      ),
                      Switch(
                        value: _switchReschedule,
                        onChanged: _switchRescheduleChange,
                        activeTrackColor: Color.fromRGBO(122, 205, 198, 1),
                        activeColor: Color.fromRGBO(122, 205, 198, 1),
                        inactiveTrackColor: Color.fromRGBO(234, 234, 234, 0.5),
                        inactiveThumbColor: Color.fromRGBO(122, 205, 198, 1),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: 295.93,
                    height: 67.65,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Text(
                        'SAVE',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Color.fromRGBO(122, 205, 198, 1),
                      onPressed: () {
                        Todo todo = Todo(
                          title: titleController.text,
                        );
                        widget.addTodoCallback(todo);
                        Navigator.of(context).pop(
                          MaterialPageRoute(
                              builder: (_) => ReviewCreatedGoal()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          side: BorderSide(
                              color: Color.fromRGBO(122, 205, 198, 1))),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
