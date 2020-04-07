import 'dart:async';

import 'package:aimify/Calendar/CalendarMainPage.dart';
import 'package:aimify/Profile/CompleteProfile.dart';
import 'package:aimify/services/auth/AuthService.dart';
import 'package:aimify/FastView/FastView.dart';
import 'package:aimify/FastView/GoalItem.dart';
import 'package:flutter/material.dart';

import 'AuthenticationState.dart';
import 'Category/SelectCategory.dart';

class HomePage extends StatefulWidget {
  final StreamController<AuthenticationState> _streamController;
  final AuthService _authService;
  const HomePage(this._streamController,this._authService);
  @override
  _HomePageState createState() => _HomePageState(_streamController,_authService);
}

class _HomePageState extends State<HomePage> {
    final StreamController<AuthenticationState> _streamController;
    final AuthService _authService;

  _HomePageState(this._streamController,this._authService);
  List<GoalItem> goalItemList = List();
  void changeTabCallback(int value, GoalItem goalItem) {
    setState(() {
      goalItemList.add(goalItem);
      _selectedIndex = value;
    });
  }

  @override
  void initState() {
    _widgetOptions = <Widget>[
      // Text(
      //   'Choose Category',
      //   style: optionStyle,
      // ),
      SelectCategory(changeTabCallback: changeTabCallback),
      FastView(goalItemList: goalItemList,),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      CalendarMainPage(),
      Text(
        'Index 4: School',
        style: optionStyle,
      ),
    ];
    super.initState();
  }
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
      List<Widget> _widgetOptions = <Widget>[
      // Text(
      //   'Choose Category',
      //   style: optionStyle,
      // ),
      SelectCategory(),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
      CalendarMainPage(),
      CompleteProfile(_streamController, _authService)
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      resizeToAvoidBottomPadding: false,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/png/004-store-new-badges.png"),
              // color: Colors.grey[700],
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/png/005-user.png"),
              // color: Colors.grey[700],
            ),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/png/003-explore.png"),
              // color: Colors.grey[700],
            ),
            title: Text('School'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/png/001-date.png"),
              // color: Colors.grey[700],
            ),
            title: Text('School'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/png/002-gear-option.png"),
              // color: Colors.grey[700],
            ),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Color.fromRGBO(122, 205, 198, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
