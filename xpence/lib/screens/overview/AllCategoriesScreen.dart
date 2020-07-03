import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpence/models/HelperMethods.dart';
import 'dart:async';

class AllCategories extends StatefulWidget {
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  Map _pageData;
  bool _isLoading = true;

  _getData() async {
    Map _data = await HelperMethods().getCurrentStatics();
    setState(() {
      _pageData = _data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: double.maxFinite,
            color: Color.fromRGBO(241, 202, 187, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Overview",
                        style: TextStyle(
                            fontSize: 29, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 50)),
                  ],
                ),
                Center(
                  child: Text(
                    DateFormat.yMMMM().format(DateTime.now()),
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 465,
            decoration: BoxDecoration(
              color: Color.fromRGBO(82, 92, 103, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70), topRight: Radius.circular(70)),
            ),
          ),
          Positioned(
            bottom: 35,
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: 349,
                    height: 526,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        borderRadius: BorderRadius.circular(42)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        padding: EdgeInsets.all(15),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(223, 208, 252, 1),
                                  Color.fromRGBO(169, 134, 243, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Icon(
                                Icons.shopping_cart,
                                size: 35,
                                color: Colors.black54,
                              ),
                              title: Text("Grocery"),
                              subtitle: Text("Rs.${_pageData['grocery']}"),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(248, 222, 220, 1),
                                  Color.fromRGBO(251, 175, 165, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Icon(
                                Icons.fastfood,
                                size: 35,
                                color: Colors.black54,
                              ),
                              title: Text("Food"),
                              subtitle: Text("Rs.${_pageData['food']}"),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(200, 244, 254, 1),
                                  Color.fromRGBO(122, 223, 246, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Icon(
                                Icons.directions_car,
                                color: Colors.black54,
                                size: 35,
                              ),
                              title: Text("Transportation"),
                              subtitle:
                                  Text("Rs.${_pageData['transportation']}"),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(246, 217, 232, 1),
                                  Color.fromRGBO(249, 176, 215, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Colors.black54,
                                size: 35,
                              ),
                              title: Text("Clothing"),
                              subtitle: Text("Rs.${_pageData['clothing']}"),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(248, 222, 220, 1),
                                  Color.fromRGBO(251, 175, 165, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Icon(
                                Icons.local_hospital,
                                size: 35,
                                color: Colors.black54,
                              ),
                              title: Text("Medical"),
                              subtitle: Text("Rs.${_pageData['medical']}"),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(200, 244, 254, 1),
                                  Color.fromRGBO(122, 223, 246, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: Icon(
                                Icons.person_outline,
                                size: 35,
                                color: Colors.black54,
                              ),
                              title: Text("Other"),
                              subtitle: Text("Rs.${_pageData['other']}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      )),
    );
  }
}
