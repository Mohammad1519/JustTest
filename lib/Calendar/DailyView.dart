import 'package:aimify/Calendar/week_view.dart';
import 'package:flutter/material.dart';

import 'event.dart';

class DailyView extends StatefulWidget {
  @override
  _DailyViewState createState() => _DailyViewState();
}



class _DailyViewState extends State<DailyView> {
  List<FlutterWeekViewEvent> events = List();
    DateTime now = DateTime.now();
    DateTime date ;

  @override
  void initState() {
    date =  DateTime(now.year, now.month, now.day);
    // TODO: Get Events from DataBase 
    events.add(FlutterWeekViewEvent(title: 'TestEvent' ,description: 'Event1' ,start:date.subtract(const Duration(hours: 1)),end: date.add(const Duration(hours: 2, minutes: 30))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WeekView(
      dayBarTextStyle: TextStyle(color: Colors.grey),
      // dayBarBackgroundColor: Colors.transparent,
      hoursColumnBackgroundColor: Colors.transparent,
    
      dayViewWidth: MediaQuery.of(context).size.width * 4/7,
      dates: [
        date,
        date.add(const Duration(days: 1)),
        date.add(const Duration(days: 2)),
        date.add(const Duration(days: 3)),
        date.add(const Duration(days: 4)),
        date.add(const Duration(days: 5)),
        date.add(const Duration(days: 6))
      ],
    
      events: events,
    );
  }
}
