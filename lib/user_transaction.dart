import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {

  final Function add;

  UserTransaction(this.add);

  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
          ),
          TextButton(
              onPressed: () {
                widget.add(
                    titleController.text, double.parse(amountController.text));
              },
              child: Text('Add'))
        ],
      ));
  }
}
