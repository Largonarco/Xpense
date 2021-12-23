import 'package:flutter/material.dart';
import 'package:xpense/chart_bar.dart';
import 'package:xpense/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> userTransactions;
  num weeklySum = 0.0;

  Chart(this.userTransactions);

  List<Map> get recentTx {
    return List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: index));
      var sum = 0.0;

      for (var i = 0; i < userTransactions.length; i++) {
        if (userTransactions[i].date.day == date.day &&
            userTransactions[i].date.month == date.month) {
          sum += userTransactions[i].amount;
          weeklySum += userTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(date).substring(0, 1),
        'amount': sum
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: recentTx.map((tx) {
          return Expanded(
            child: ChartBar(tx['day'], tx['amount'],
                weeklySum == 0 ? 0 : tx['amount'] / weeklySum),
          );
        }).toList(),
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
