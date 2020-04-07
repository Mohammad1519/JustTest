import 'package:aimify/FastView/AddNote.dart';
import 'package:aimify/FastView/Attachments.dart';
import 'package:aimify/FastView/GoalItem.dart';
import 'package:aimify/FastView/Invite.dart';
import 'package:aimify/FastView/InviteFriend.dart';
import 'package:aimify/FastView/ItemDetail.dart';
import 'package:aimify/FastView/RequestToCoach.dart';
import 'package:flutter/material.dart';

class FastView extends StatefulWidget {
  final List<GoalItem> goalItemList;

  const FastView({Key key, this.goalItemList}) : super(key: key);
  @override
  _FastViewState createState() => _FastViewState();
}

class _FastViewState extends State<FastView> {
  bool isCheckScreen = false;
  bool isFastViewScreen = true;
  bool isAddNoteScreen = false;
  bool isAttachmentsScreen = false;
  bool isInviteScreen = false;
  bool isInviteFriendScreen = false;
  var itemDetail = ItemDetail();
  List<GoalItem> _goalItems = List();

  void changeisCheckScreen(String endDate, String goalTitle, String todoTitle) {
    setState(() {
      itemDetail = ItemDetail(
        endDate: endDate,
        goalTitle: goalTitle,
        todoTitle: todoTitle,
        changeisCheckScreen: changeisCheckScreen,
      );
      isCheckScreen = !isCheckScreen;
    });
  }

  void changeIsAddNote() {
    setState(() {
      isAddNoteScreen = !isAddNoteScreen;
    });
  }

  void changeIsAttachments() {
    setState(() {
      isAttachmentsScreen = !isAttachmentsScreen;
    });
  }

  void changeIsInvite() {
    setState(() {
      isInviteScreen = !isInviteScreen;
    });
  }

  void changeIsInviteFriend() {
    setState(() {
      isInviteFriendScreen = !isInviteFriendScreen;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < widget.goalItemList.length; i++) {
      _goalItems.add(GoalItem(
          endDate: widget.goalItemList[i].endDate,
          todoList: widget.goalItemList[i].todoList,
          title: widget.goalItemList[i].title,
          percent: widget.goalItemList[i].percent,
          changeisCheckScreen: changeisCheckScreen,
          changeIsAddNote: changeIsAddNote,
          changeIsAttachments: changeIsAttachments,
          changeIsInvite: changeIsInvite,
          changeIsInviteFriend: changeIsInviteFriend));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      padding: EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 10),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => RequestToCoach()),
              );
            },
            child: Row(
              children: <Widget>[
                Text("REQUEST TO COACH"),
                Expanded(
                  child: Container(),
                ),
                Text("12")
              ],
            ),
          ),
          Divider(
            color: Colors.black87,
          ),
          Column(children: _goalItems),
        ],
      ),
    );
    if (isCheckScreen) {
      return Scaffold(
        body: itemDetail,
      );
    } else if (isAddNoteScreen) {
      return Scaffold(
        body: AddNote(
          changeIsAddNote: changeIsAddNote,
        ),
      );
    } else if (isAttachmentsScreen) {
      return Scaffold(
        body: Attachments(
          changeIsAttachments: changeIsAttachments,
        ),
      );
    } else if (isInviteScreen) {
      return Scaffold(
        body: Invite(
          changeIsInvite: changeIsInvite,
          changeIsInviteFriend: changeIsInviteFriend,
        ),
      );
    } else if (isInviteFriendScreen) {
      return Scaffold(
        body: InviteFriend(
          changeIsInviteFriend: changeIsInviteFriend,
          changeIsInvite: changeIsInvite,
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: container,
        ),
      );
    }
  }
}
