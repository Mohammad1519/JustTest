import 'package:flutter/material.dart';

class NeedCoach extends StatefulWidget {
  final String categoryTitle;
  final String subCategoryTitle;

  const NeedCoach({Key key, this.categoryTitle, this.subCategoryTitle})
      : super(key: key);
  @override
  _NeedCoachState createState() => _NeedCoachState();
}

class _NeedCoachState extends State<NeedCoach> {
  double _starValue = 1;
  double _endValue = 1000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: ButtonTheme(
                height: 40,
                minWidth: 130,
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
                  style: TextStyle(fontSize: 18),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                child: Text(
                  widget.subCategoryTitle ?? 'null',
                  style: TextStyle(fontSize: 18),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                child: Text(
                  'PRICE',
                  style: TextStyle(fontSize: 18),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Text(
                        _starValue.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), '') + " \$",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Text(_endValue.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "") + " \$"),
                    ),
                  ],
                ),
                RangeSlider(
                  activeColor: Colors.black,
                  max: 1000,
                  min: 1,
                  values: RangeValues(_starValue, _endValue),
                  onChanged: (values) {
                    setState(() {
                      _starValue = values.start.roundToDouble();
                      _endValue = values.end.roundToDouble();
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                child: Text(
                  'SEARCH',
                  style: TextStyle(fontSize: 18),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            Container(
              color: Color.fromRGBO(234, 234, 234, 1),
              child: TextField(
                  decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 21),
                hintText: 'type here ...',
              )),
            ),
          ],
        ),
      ),
    ));
  }
}
