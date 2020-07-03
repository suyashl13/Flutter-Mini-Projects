import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

import 'package:xpence/db/database_helper.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> _followUsDialoguebox() async {
      return showDialog(
        context: context,
        builder: (context) => Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            height: 250,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: ListTile(
                        title: Center(
                            child: Text(
                      "Follow us",
                      style: TextStyle(),
                    ))),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: ListTile(
                      title: Center(
                          child: Text(
                        "@suyeshlawand",
                        style: TextStyle(color: Colors.white),
                      )),
                      onTap: () async {
                        const url = 'https://www.instagram.com/suyeshlawand/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              offset: Offset(-3, 2))
                        ],
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(162, 230, 254, 1),
                          Color.fromRGBO(101, 183, 255, 1),
                        ])),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: ListTile(
                      title: Center(
                          child: Text(
                        "@pachack_studio",
                        style: TextStyle(color: Colors.white),
                      )),
                      onTap: () async {
                        const url = 'https://www.instagram.com/pachack_studio/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.grey,
                              offset: Offset(-3, 2))
                        ],
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(162, 230, 254, 1),
                          Color.fromRGBO(101, 183, 255, 1),
                        ])),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: double.maxFinite,
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "INFO",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 3,
              ),
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 273,
          decoration: BoxDecoration(
            color: Color.fromRGBO(183, 150, 255, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70), topRight: Radius.circular(70)),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 230,
          decoration: BoxDecoration(
            color: Color.fromRGBO(254, 181, 172, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70), topRight: Radius.circular(70)),
          ),
        ),
        Positioned(
          bottom: 50,
          child: Container(
            width: 340,
            height: 360,
            decoration: BoxDecoration(
                color: Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(42)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(223, 208, 252, 1),
                          Color.fromRGBO(169, 134, 243, 1),
                        ]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8,
                              offset: Offset(1, 5)),
                        ],
                      ),
                      child: ListTile(
                        onTap: _followUsDialoguebox,
                        leading: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Follow us",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(223, 208, 252, 1),
                          Color.fromRGBO(169, 134, 243, 1),
                        ]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8,
                              offset: Offset(1, 5)),
                        ],
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.bug_report,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Report bug",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                          const emailaddress =
                              'mailto:suyash.lawand@gmail.com?subject=Reporting a bug in xpence app.&body=';
                          if (await canLaunch(emailaddress)) {
                            await launch(emailaddress);
                          } else {
                            throw 'Could not Email';
                          }
                        },
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(colors: [
                          Color.fromRGBO(223, 208, 252, 1),
                          Color.fromRGBO(169, 134, 243, 1),
                        ]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8,
                              offset: Offset(1, 5)),
                        ],
                      ),
                      child: ListTile(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Container(
                                child: Text("Are you sure want to reset app ?"),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      await DatabaseHelper().turnCateTransactions();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Yes")),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No")),
                              ],
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        title: Text(
                          "Reset",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
