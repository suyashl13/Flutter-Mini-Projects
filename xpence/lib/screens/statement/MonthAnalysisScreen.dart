import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:xpence/db/database_helper.dart';
import 'package:xpence/models/HelperMethods.dart';

class MonthlyAnalysisScreen extends StatefulWidget {
  String month;
  MonthlyAnalysisScreen({@required this.month});
  @override
  _MonthlyAnalysisScreenState createState() =>
      _MonthlyAnalysisScreenState(month: this.month);
}

class _MonthlyAnalysisScreenState extends State<MonthlyAnalysisScreen> {
  String month;
  List<Map<String, dynamic>> _screenData;
  bool _isLoading = true;
  int _cost = 0;

  Future<void> _setScreenData() async {
    List<Map<String, dynamic>> data =
        await DatabaseHelper().getTransactionsByMonth(month);
    var cst = await HelperMethods().getCustomMonthExpenditureCost(month);
    setState(() {
      _screenData = data;
      _isLoading = false;
      _cost = cst;
    });
  }

  _promptPieChart() async {
    Map<String, double> _dataMap = await HelperMethods().getCustomStaticsInDouble(month);
    List<Color> colors = [
      Color.fromRGBO(183, 150, 255, 1),
      Color.fromRGBO(254, 181, 172, 1),
      Color.fromRGBO(162, 230, 245, 1),
      Color.fromRGBO(252, 187, 222, 1),
      Colors.redAccent,
      Colors.grey,
    ];
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          height: 400,
          child: PieChart(
            dataMap: _dataMap,
            chartType: ChartType.disc,
            colorList: colors,
            chartRadius: 146,
            legendPosition: LegendPosition.bottom,
          ),
        ),
      ),
    );
  }

  _MonthlyAnalysisScreenState({@required this.month});

  @override
  void initState() {
    super.initState();
    this._setScreenData();
  }

  _detailedExpenditure(Map<String, dynamic> expDetail) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Container(
          height: 325,
          width: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  "${expDetail['category']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  "${expDetail['date']}",
                  style: TextStyle(),
                )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("${expDetail['title']}"),
                      Card(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Rs.${expDetail['amount']}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  child: Text("Delete"),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  onPressed: () {
                    setState(() {
                      DatabaseHelper().deleteTransaction(expDetail['id']);
                      Navigator.pop(context);
                      this._setScreenData();
                    });
                  },
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  child: Text("Okay"),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Color.fromRGBO(241, 202, 187, 1),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
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
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "${month}'s",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 0.5,
                          ),
                          Center(
                            child: Text(
                              "Expenditure",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Rs.${_cost}",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(Icons.pie_chart_outlined),
                          onPressed: _promptPieChart,
                        )
                    ],
                  ),
                )
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
              child: Container(
                width: 349,
                height: 526,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    borderRadius: BorderRadius.circular(42)),
                child: _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        child: ListView.builder(
                          itemCount: _screenData.length,
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(bottom: 08),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(248, 222, 220, 1),
                                  Color.fromRGBO(251, 175, 165, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: _screenData[index]['category'] ==
                                      "GROCERY"
                                  ? Icon(
                                      Icons.shopping_cart,
                                      size: 30,
                                      color: Colors.black54,
                                    )
                                  : _screenData[index]['category'] == "FOOD"
                                      ? Icon(
                                          Icons.fastfood,
                                          size: 30,
                                          color: Colors.black54,
                                        )
                                      : _screenData[index]['category'] ==
                                              "TRANSPORTATION"
                                          ? Icon(
                                              Icons.directions_car,
                                              color: Colors.black54,
                                              size: 30,
                                            )
                                          : _screenData[index]['category'] ==
                                                  "CLOTHING"
                                              ? Icon(
                                                  Icons.person,
                                                  color: Colors.black54,
                                                  size: 30,
                                                )
                                              : _screenData[index]
                                                          ['category'] ==
                                                      "MEDICAL"
                                                  ? Icon(
                                                      Icons.local_hospital,
                                                      size: 30,
                                                      color: Colors.black54,
                                                    )
                                                  : Icon(
                                                      Icons.person_outline,
                                                      size: 30,
                                                      color: Colors.black54,
                                                    ),
                              title: Text(
                                "${_screenData[index]['title']}",
                                style: TextStyle(),
                              ),
                              subtitle: Text(
                                "Rs.${_screenData[index]['amount']} ( ${_screenData[index]['date']} )",
                                style: TextStyle(),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                size: 35,
                                color: Colors.white,
                              ),
                              onTap: () async {
                                _detailedExpenditure(_screenData[index]);
                              },
                            ),
                          ),
                        ),
                      ),
              ))
        ],
      )),
    );
  }
}
