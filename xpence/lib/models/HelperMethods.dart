import 'package:xpence/db/database_helper.dart';
import 'package:xpence/db/database_helper.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HelperMethods {
  DatabaseHelper db;

  getTodaysExpenditureCost() async {
    var a = await DatabaseHelper()
        .getTodaysTransactions(DateFormat.yMMMd().format(DateTime.now()));
    int cost = 0;
    for (var i in a) {
      cost += i['amount'];
    }
    if (a == null) {
      return 0;
    } else {
      return cost;
    }
  }

  getCurrentMonthsExpenditureCost() async {
    var a = await DatabaseHelper()
        .getTransactionsByMonth(DateFormat.yMMMM().format(DateTime.now()));
    int cost = 0;
    for (var i in a) {
      cost += i['amount'];
    }
    if (a == null) {
      return 0;
    } else {
      return cost;
    }
  }

  getCurrentStatics() async {
    int grocery = 0;
    int food = 0;
    int transportation = 0;
    int clothing = 0;
    int medical = 0;
    int other = 0;

    var data = await DatabaseHelper()
        .getCategoryAndAmountOfMonth(DateFormat.yMMMM().format(DateTime.now()));

    for (Map<String, dynamic> i in data) {
      if (i['category'] == "GROCERY") {
        grocery += i['amount'];
      } else if (i['category'] == "FOOD") {
        food += i['amount'];
      } else if (i['category'] == "TRANSPORTATION") {
        transportation += i['amount'];
      } else if (i['category'] == "CLOTHING") {
        clothing += i['amount'];
      } else if (i['category'] == "MEDICAL") {
        medical += i['amount'];
      } else if (i['category'] == "OTHER") {
        other += i['amount'];
      }
    }
    Map pieData = {
      "grocery": grocery,
      "food": food,
      "transportation": transportation,
      "clothing": clothing,
      "medical": medical,
      "other": other
    };
    return pieData;
  }

  getCurrentStaticsInDouble() async {
    int grocery = 0;
    int food = 0;
    int transportation = 0;
    int clothing = 0;
    int medical = 0;
    int other = 0;

    var data = await DatabaseHelper()
        .getCategoryAndAmountOfMonth(DateFormat.yMMMM().format(DateTime.now()));

    for (Map<String, dynamic> i in data) {
      if (i['category'] == "GROCERY") {
        grocery += i['amount'];
      } else if (i['category'] == "FOOD") {
        food += i['amount'];
      } else if (i['category'] == "TRANSPORTATION") {
        transportation += i['amount'];
      } else if (i['category'] == "CLOTHING") {
        clothing += i['amount'];
      } else if (i['category'] == "MEDICAL") {
        medical += i['amount'];
      } else if (i['category'] == "OTHER") {
        other += i['amount'];
      }
    }
    Map<String, double> pieData = {
      "grocery": grocery.toDouble(),
      "food": food.toDouble(),
      "transportation": transportation.toDouble(),
      "clothing": clothing.toDouble(),
      "medical": medical.toDouble(),
      "other": other.toDouble()
    };
    return pieData;
  }

  getCustomStaticsInDouble(String monthYear) async {
    int grocery = 0;
    int food = 0;
    int transportation = 0;
    int clothing = 0;
    int medical = 0;
    int other = 0;

    var data = await DatabaseHelper()
        .getCategoryAndAmountOfMonth(monthYear);

    for (Map<String, dynamic> i in data) {
      if (i['category'] == "GROCERY") {
        grocery += i['amount'];
      } else if (i['category'] == "FOOD") {
        food += i['amount'];
      } else if (i['category'] == "TRANSPORTATION") {
        transportation += i['amount'];
      } else if (i['category'] == "CLOTHING") {
        clothing += i['amount'];
      } else if (i['category'] == "MEDICAL") {
        medical += i['amount'];
      } else if (i['category'] == "OTHER") {
        other += i['amount'];
      }
    }
    Map<String, double> pieData = {
      "grocery": grocery.toDouble(),
      "food": food.toDouble(),
      "transportation": transportation.toDouble(),
      "clothing": clothing.toDouble(),
      "medical": medical.toDouble(),
      "other": other.toDouble()
    };
    return pieData;
  }


  getCustomMonthExpenditureCost(String month) async {
    var a = await DatabaseHelper()
        .getTransactionsByMonth(month);
    int cost = 0;
    for (var i in a) {
      cost += i['amount'];
    }
    if (a == null) {
      return 0;
    } else {
      return cost;
    }
  }


}
