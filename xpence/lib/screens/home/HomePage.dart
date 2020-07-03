import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpence/db/database_helper.dart';
import 'package:xpence/models/HelperMethods.dart';
import 'dart:async';
import 'package:xpence/models/Transaction.dart';

class HomePage extends StatefulWidget {
  BuildContext scaffoldContext;
  HomePage({@required this.scaffoldContext});

  @override
  _HomePageState createState() =>
      _HomePageState(scaffoldContext: scaffoldContext);
}

class _HomePageState extends State<HomePage> {
  BuildContext scaffoldContext;
  _HomePageState({@required this.scaffoldContext});
  int todaysExpenditure = 0;
  int currentMonthExpenditure = 0;

  Future<void> _noteAnExpenditure() async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _category = "OTHER";
    String _product;
    int _amount;
    return showDialog(
        context: context,
        builder: (BuildContext bcontext) => StatefulBuilder(
              builder: (mcontext, setState) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26)),
                child: Container(
                  height: 410,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "I spend",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              // ignore: missing_return
                              validator: (i) {
                                if (i.length == 0) {
                                  return "This field is required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  _amount = int.parse(value);
                                });
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Amount",
                                  border: OutlineInputBorder(),
                                  hintText: "Enter amount you spent"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "For Buying",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (i) {
                                if (i.length == 0) {
                                  return "This field is required";
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  _product = value;
                                });
                              },
                              decoration: InputDecoration(
                                  labelText: "Product",
                                  border: OutlineInputBorder(),
                                  hintText: "Enter product"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "For",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButton<String>(
                              items: <String>[
                                'GROCERY',
                                'FOOD',
                                'TRANSPORTATION',
                                'CLOTHING',
                                'MEDICAL',
                                'OTHER'
                              ].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _category = val;
                                  print(_category);
                                });
                              },
                              value: _category,
                              hint: Text("Select"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              elevation: 5.0,
                              child: Text(
                                "NOTE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  DbTransaction _dbtransaction;
                                  setState(() {
                                    _dbtransaction = DbTransaction(
                                        category: _category,
                                        title: _product,
                                        date: DateFormat.yMMMd()
                                            .format(DateTime.now()),
                                        amount: _amount,
                                        month: DateFormat.yMMMM()
                                            .format(DateTime.now()));
                                  });
                                  try {
                                    var a = await DatabaseHelper()
                                        .insertTransaction(_dbtransaction);
                                    print(a);
                                    _setExpenditureVariable();
                                    Navigator.pop(context);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        backgroundColor:
                                            Color.fromRGBO(183, 150, 255, 1),
                                        content: Text(
                                            "Expenditure added successfully.")));
                                  } catch (e) {
                                    Scaffold.of(scaffoldContext).showSnackBar(
                                        SnackBar(
                                            backgroundColor:
                                                Color.fromRGBO(183, 150, 255, 1),
                                            content: Text(
                                                "Failed to add expenditure.")));
                                  }
                                }
                              },
                              color: Color.fromRGBO(183, 150, 255, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Future<void> _setExpenditureVariable() async {
    final int todayExp = await HelperMethods().getTodaysExpenditureCost();
    final int monthExp =
        await HelperMethods().getCurrentMonthsExpenditureCost();
    setState(() {
      todaysExpenditure = todayExp;
      currentMonthExpenditure = monthExp;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._setExpenditureVariable();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 55,
              ),
              Text(
                "${DateFormat.yMMMd().format(DateTime.now())}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "EXPENDITURE OF THIS MONTH",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                "Rs.${currentMonthExpenditure}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 473,
          decoration: BoxDecoration(
            color: Color.fromRGBO(183, 150, 255, 1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70), topRight: Radius.circular(70)),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 330,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Note an expinditure",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  elevation: 5.0,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Text(
                    "NOTE",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                  onPressed: _noteAnExpenditure,
                  color: Color.fromRGBO(183, 150, 255, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Today",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  "Rs.${todaysExpenditure}",
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(254, 181, 172, 1),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
