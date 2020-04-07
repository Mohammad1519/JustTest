import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'CategoryItem.dart';

class SelectCategory extends StatefulWidget {
  final Function changeTabCallback;

  const SelectCategory({Key key, this.changeTabCallback}) : super(key: key); 
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  String categoryTitle = '';
  bool iscategorySelect = false;
  List<CategoryItem> listItems = List();
  List<CategoryItem> listSubItems = List();

  Future<List<CategoryItem>> _fetchCategoryItems() async {
    //TODO fetch listItems from api
    String res = '[{ "cat": "CATEGOURY 1","id": 1,"count": 28,"img": "https://i.picsum.photos/id/867/400/200.jpg"},' +
        '{ "cat": "Test2","id": 2,"count": 21,"img": "https://i.picsum.photos/id/87/400/200.jpg"},' +
        '{ "cat": "Test2","id": 3,"count": 21,"img": "https://i.picsum.photos/id/267/400/200.jpg"},' +
        '{ "cat": "Test2","id": 4,"count": 21,"img": "https://www.w3schools.com/w3css/img_lights.jpg"}]';

    final items = jsonDecode(res).cast<Map<String, dynamic>>();
    List<CategoryItem> categoryItem = items.map<CategoryItem>((json) {
      return CategoryItem.fromJson(json);
    }).toList();
    return categoryItem;
  }

  Future<List<CategoryItem>> _fetchSubCategoryItems(int id) async {
    //TODO fetch listItems from api
    String res = '';

    switch (id) {
      case 1:
        res = '[{ "cat": "Sub2","id": 1,"count": 28,"img": "https://i.picsum.photos/id/867/400/200.jpg"},' +
            '{ "cat": "Test2","id": 2,"count": 21,"img": "https://i.picsum.photos/id/65/400/200.jpg"},' +
            '{ "cat": "Test2","id": 3,"count": 21,"img": "https://i.picsum.photos/id/35/400/200.jpg"},' +
            '{ "cat": "Test2","id": 4,"count": 21,"img": "https://www.w3schools.com/w3css/img_lights.jpg"}]';

        break;
      case 2:
        res = '[{ "cat": "Sub 3","id": 1,"count": 28,"img": "https://i.picsum.photos/id/222/400/200.jpg"},' +
            '{ "cat": "Test2","id": 2,"count": 21,"img": "https://i.picsum.photos/id/2/400/200.jpg"},' +
            '{ "cat": "Test2","id": 3,"count": 21,"img": "https://i.picsum.photos/id/22/400/200.jpg"},' +
            '{ "cat": "Test2","id": 4,"count": 21,"img": "https://www.w3schools.com/w3css/img_lights.jpg"}]';

        break;
      case 3:
        res = '[{ "cat": "sub 4","id": 1,"count": 28,"img": "https://i.picsum.photos/id/353/400/200.jpg"},' +
            '{ "cat": "Test2","id": 2,"count": 21,"img": "https://i.picsum.photos/id/33/400/200.jpg"},' +
            '{ "cat": "Test2","id": 3,"count": 21,"img": "https://i.picsum.photos/id/532/400/200.jpg"},' +
            '{ "cat": "Test2","id": 4,"count": 21,"img": "https://www.w3schools.com/w3css/img_lights.jpg"}]';

        break;
      default:
        res = '[{ "cat": "CATEGOURY 1","id": 1,"count": 28,"img": "https://i.picsum.photos/id/3/400/200.jpg"},' +
            '{ "cat": "Test2","id": 2,"count": 21,"img": "https://i.picsum.photos/id/1/400/200.jpg"},' +
            '{ "cat": "Test2","id": 3,"count": 21,"img": "https://i.picsum.photos/id/2/400/200.jpg"},' +
            '{ "cat": "Test2","id": 4,"count": 21,"img": "https://www.w3schools.com/w3css/img_lights.jpg"}]';

        break;
    }

    final items = jsonDecode(res).cast<Map<String, dynamic>>();
    List<CategoryItem> categoryItem = items.map<CategoryItem>((json) {
      return CategoryItem.fromJson(json);
    }).toList();
    return categoryItem;
  }

  void callBack(flag, id, title) {
    if (flag) {
      _fetchSubCategoryItems(id).then((list) {
        setState(() {
          categoryTitle = title;
          listSubItems = list;
          print("flag =$flag");
          iscategorySelect = flag;
        });
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _fetchCategoryItems().then((list) {
      setState(() {
        listItems = list;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var container = Container(
      padding: EdgeInsets.only(top: 50, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              child: Text(
                'CHOOSE',
                style: TextStyle(fontSize: 18),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: listItems
                  .map<Widget>((item) => CategoryItem(
                        categoryTitle: item.categoryTitle,
                        image: item.image,
                        id: item.id,
                        couchCount: item.couchCount,
                        selectCategorySetState: callBack,
                        isCurrentSubCategory: false,
                        parentCategory: categoryTitle ?? ' ',
                        changeTabCallback:widget.changeTabCallback,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
    var subContainer = Container(
      padding: EdgeInsets.only(top: 50, left: 10, right: 10),
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
                  setState(() {
                    iscategorySelect = false;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              child: Text(
                categoryTitle,
                style: TextStyle(fontSize: 15),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              child: Text(
                'SUB CATEGORY',
                style: TextStyle(fontSize: 15),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: listSubItems
                  .map<Widget>((item) => CategoryItem(
                        categoryTitle: item.categoryTitle,
                        image: item.image,
                        id: item.id,
                        couchCount: item.couchCount,
                        selectCategorySetState: callBack,
                        isCurrentSubCategory: true,
                        parentCategory: categoryTitle ?? ' ',
                        changeTabCallback:widget.changeTabCallback,
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
    return Scaffold(
      body: iscategorySelect ? subContainer : container,
    );
  }
}
