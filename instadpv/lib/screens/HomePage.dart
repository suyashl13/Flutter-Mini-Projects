import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String domain = "https://www.instagram.com/";
  String last = "/?__a=1";
  String url, profilepic_url;

  downloadDP(String url) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Do you want to download the display picture ?"),
        actions: <Widget>[
          FlatButton(
              onPressed: () async {
                try {
                  var imageId = await ImageDownloader.downloadImage(url);
                  if (imageId == null) {
                    print("Done");
                  }
                } catch (e) {
                  print(e);
                }
                Navigator.pop(context);
              },
              child: Text("Yes")),
          FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("No"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        body: Builder(
          builder: (scontext) => Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                  0.3,
                  1
                ],
                    colors: <Color>[
                  Color.fromRGBO(76, 221, 242, 1),
                  Color.fromRGBO(92, 121, 255, 1),
                ])),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 320,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 28, horizontal: 0),
                          child: Container(
                            height: 300,
                            child: profilepic_url != null
                                ? GestureDetector(
                                    onLongPress: () async {
                                      downloadDP(profilepic_url);
                                    },
                                    child: Image.network(profilepic_url))
                                : Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 18.0, right: 18, bottom: 10),
                          child: TextFormField(
                            onChanged: (username) {
                              setState(() {
                                url = domain + username.trim() + last;
                              });
                            },
                            key: formKey,
                            validator: (value) => value.length == 0
                                ? "Please Enter IG Username"
                                : null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "@Username",
                                hintText: 'IG Username'),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CupertinoButton(
                            child: Text("Display Profile Picture"),
                            color: Color.fromRGBO(92, 121, 255, 1),
                            onPressed: () async {
                              var body;
                              try {
                                http.Response response = await http.get(url);
                                body = jsonDecode(response.body);
                              } catch (e) {
                                Scaffold.of(scontext).showSnackBar(SnackBar(
                                    content: Text("Invalid username")));
                              }
                              setState(() {
                                try {
                                  profilepic_url = body['graphql']['user']
                                      ['profile_pic_url_hd'];
                                } catch (e) {
                                  Scaffold.of(scontext).showSnackBar(SnackBar(
                                      content: Text("Invalid username")));
                                }
                              });
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
