import 'package:flutter/material.dart';
import 'package:xpence/screens/home/HomePage.dart';
import 'package:xpence/screens/info/InfoScreen.dart';
import 'package:xpence/screens/overview/PieChartScreen.dart';
import 'package:xpence/screens/statement/ExpStatementScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    List screens = [
    HomePage(scaffoldContext: context,),
    PieChartScreen(),
    ExpStatementScreen(),
    InfoScreen()
  ];
    return SafeArea(
          child: Scaffold(
        body: screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.grey,
          fixedColor: Color.fromRGBO(254, 181, 172, 1),
          iconSize: 24,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text("Stats")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Expenditure")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text("Info")
            )
          ],
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}