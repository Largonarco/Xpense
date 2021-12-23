import 'package:flutter/material.dart';
import './chart.dart';
import './transaction_list.dart';
import './user_transaction.dart';
import './models/transaction.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpense',
      home: HomePage(),
      theme:
          ThemeData(primarySwatch: Colors.teal, accentColor: Colors.tealAccent),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Transaction> _userTransactions = [
    Transaction(
        id: '1',
        title: 'Groceries',
        amount: 50,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        id: '2',
        title: 'Chocolate',
        amount: 30,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: '3',
        title: 'Snacks',
        amount: 100,
        date: DateTime.now().subtract(Duration(days: 4))),
  ];

  void _addTx(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: Random().toString());

    if (title.isEmpty || amount.isNegative) {
      return;
    }

    setState(() {
      _userTransactions.add(newTx);
    });

    Navigator.of(context).pop();
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _dispalyModalSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return UserTransaction(_addTx);
        });
  }

  List<Transaction> get _recentTx {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  var appBar = AppBar(
    title: Text('Xpense'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _dispalyModalSheet(context),
      ),
      body: ListView(children: [
        Column(
          children: [
            
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBar.preferredSize.height) *
                  0.3,
              child: Chart(_recentTx),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      appBar.preferredSize.height) *
                  0.7,
              child: TransactionList(_userTransactions, _deleteTx),
            ),
          ],
        ),
      ]),
    );
  }
}
