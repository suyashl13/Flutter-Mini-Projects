import 'package:flutter/material.dart';
import 'package:xpence/db/database_helper.dart';
import 'package:xpence/models/HelperMethods.dart';
import 'package:xpence/screens/statement/MonthAnalysisScreen.dart';

class ExpStatementScreen extends StatefulWidget {
  @override
  _ExpStatementScreenState createState() => _ExpStatementScreenState();
}

class _ExpStatementScreenState extends State<ExpStatementScreen> {
  List<Map<String, dynamic>> _monthdata;
  bool _isLoading = true;

  Future<void> _setMonthData() async {
    List<Map<String, dynamic>> data = await DatabaseHelper().getMonths();
    setState(() {
      _monthdata = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._setMonthData();
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
                height: 25,
              ),
              Center(
                child: Text(
                  "Expenditure",
                  style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
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
                margin: EdgeInsets.only(bottom: 25),
                width: 349,
                height: 526,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    borderRadius: BorderRadius.circular(42)),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemCount: _monthdata.length,
                          itemBuilder: (context, i) => Container(
                            margin: EdgeInsets.only(bottom: 08),
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(248, 222, 220, 1),
                                  Color.fromRGBO(251, 175, 165, 1),
                                ]),
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(
                                "${_monthdata[i]['month']}",
                                style: TextStyle(),
                              ),
                              trailing: Icon(
                                Icons.keyboard_arrow_right,
                                size: 35,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MonthlyAnalysisScreen(
                                        month: _monthdata[i]['month'])));
                              },
                            ),
                          ),
                        ))))
      ],
    );
  }
}
