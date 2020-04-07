import 'package:aimify/Calendar/WeeklyView.dart';
import 'package:flutter/material.dart';
import 'DailyView.dart';
class CalendarMainPage extends StatefulWidget {
  @override
  _CalendarMainPageState createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30,left: 10,right: 10),
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(250, 250, 250, 1),
              elevation: 0,
              flexibleSpace: TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 1,
                labelColor: Colors.grey,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'DAILY',),
                  Tab(text: 'WEEKLY',),
                  Tab(text: 'MONTHLY'),
                ],
              ),
              
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                DailyView(),
                Icon(Icons.directions_bike),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
    );
  }
}