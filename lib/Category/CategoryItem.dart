import 'package:aimify/Category/CreateGoal.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  final String image;
  final String categoryTitle;
  final int couchCount;
  final int id;
  final Function selectCategorySetState;
  final bool isCurrentSubCategory;
  final String parentCategory;
  final Function changeTabCallback;
  const CategoryItem(
      {Key key,
      this.image,
      this.categoryTitle,
      this.couchCount,
      this.id,
      this.selectCategorySetState,
      this.isCurrentSubCategory,
      this.parentCategory,
      this.changeTabCallback})
      : super(key: key);
  factory CategoryItem.fromJson(Map<String, dynamic> parsedJson) {
    return CategoryItem(
      categoryTitle: parsedJson['cat'],
      image: parsedJson['img'],
      id: parsedJson['id'],
      couchCount: parsedJson['count'],
    );
  }
  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print("asasdasd");
          widget.isCurrentSubCategory
              ? Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CreateGoal(
                        categoryTitle: widget.parentCategory,
                        subCategoryTitle: widget.categoryTitle,
                        changeTabCallback :widget.changeTabCallback
                        
                      )))
              : widget.selectCategorySetState(
                  true, widget.id, widget.categoryTitle);
        },
        child: Container(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(253, 244, 234, 1),
            ),
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.categoryTitle,
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  widget.couchCount.toString() + ' coach-plans',
                  style: TextStyle(fontSize: 11),
                )
              ],
            ),
          ),
          height: 150,
          padding: EdgeInsets.all(10),
          alignment: Alignment.bottomLeft,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.image), fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
