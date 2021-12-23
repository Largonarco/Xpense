import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Center(
              child: Text(
              'No transactions found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ))
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).backgroundColor,
                        foregroundColor: Colors.black,
                        child: FittedBox(
                          child: Text(
                            '${transactions[index].amount.toStringAsFixed(0)} ₹',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        DateFormat.MMMEd().format(transactions[index].date),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.redAccent,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
                    ));
              }),
    );
  }
}
