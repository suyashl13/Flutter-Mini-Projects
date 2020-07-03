import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:xpence/db/database_helper.dart';
import 'package:xpence/models/HelperMethods.dart';
import 'package:xpence/screens/overview/AllCategoriesScreen.dart';
import 'package:intl/intl.dart';

class PieChartScreen extends StatefulWidget {
  @override
  _PieChartScreenState createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  Map<String, double> _pieData;
  bool isLoading = true;

  getPieData() async {
    Map<String, double> _data =
        await HelperMethods().getCurrentStaticsInDouble();
    setState(() {
      _pieData = _data;
      isLoading = false;
    });
  }

  List<Color> colors = [
    Color.fromRGBO(183, 150, 255, 1),
    Color.fromRGBO(254, 181, 172, 1),
    Color.fromRGBO(162, 230, 245, 1),
    Color.fromRGBO(252, 187, 222, 1),
    Colors.redAccent,
    Colors.grey,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getPieData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                height: 45,
              ),
              Center(
                child: Text(
                  "Pie Chart",
                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Center(
                child: Text(
                  "${DateFormat.yMMMM().format(DateTime.now())}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
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
          bottom: 60,
          child: Container(
            width: 349,
            height: 476,
            decoration: BoxDecoration(
                color: Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(42)),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: PieChart(
                          dataMap: _pieData,
                          colorList: colors,
                          chartType: ChartType.ring,
                          chartRadius: 146,
                          showLegends: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 28, horizontal: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 55,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(183, 150, 255, 1),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "GROCERY",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(254, 181, 172, 1),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "FOOD",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 55,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(162, 230, 245, 1),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "TRANSPORTATION",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(252, 187, 222, 1),
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "CLOTHING",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 55,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "MEDICAL",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 55,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: Center(
                                    child: Text(
                                      "OTHER",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          ),
        ),
        Positioned(
          bottom: 35,
          child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 39, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            color: Color.fromRGBO(254, 133, 88, 1),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AllCategories()));
            },
            child: Text(
              "Overview",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
