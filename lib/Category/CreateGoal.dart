import 'package:aimify/Category/NeedCoach.dart';
import 'package:aimify/Category/ReviewCreatedGoal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CreateGoal extends StatefulWidget {
  final String categoryTitle;
  final String subCategoryTitle;
  final Function changeTabCallback;

  const CreateGoal({Key key, this.categoryTitle, this.subCategoryTitle, this.changeTabCallback})
      : super(key: key);

  @override
  _CreateGoalState createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  final titleController = TextEditingController();
  String startDatePickerString;
  String endDatePickerString;

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void initState() {
    DateTime now = DateTime.now();
    startDatePickerString = DateFormat('yyyy-MMM-dd').format(now);
    endDatePickerString = ".. - ... - ....";
    super.initState();
  }

  @override
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
                    style: TextStyle(fontSize: 15),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 10),
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
                  Container(
                    width: 295.93,
                    height: 67.65,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Text(
                        'NEXT',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      color: Color.fromRGBO(122, 205, 198, 1),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => ReviewCreatedGoal(
                                  categoryTitle: widget.categoryTitle,
                                  subCategoryTitle: widget.subCategoryTitle,
                                  title: titleController.text,
                                  endDate: endDatePickerString,
                                  startDate: startDatePickerString,
                                  changeTabCallback:widget.changeTabCallback)),
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
                  Container(
                    width: 295.93,
                    height: 67.65,
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Text(
                        'I NEDD A COACH',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      color: Color.fromRGBO(253, 244, 234, 1),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => NeedCoach(
                                  categoryTitle: widget.categoryTitle,
                                  subCategoryTitle: widget.subCategoryTitle)),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          side: BorderSide(
                            color: Color.fromRGBO(253, 244, 234, 1),
                          )),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text('Please, just focus on your goal.'),
                        Text('We removed navigation in this section!'),
                        Text('BECUASE I CAN.')
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
