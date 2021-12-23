import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double amount;
  final double pct;

  ChartBar(this.day, this.amount, this.pct);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            SizedBox(height: constraints.maxHeight * 0.03,),
            Container(
              height: constraints.maxHeight * 0.15,
              child: amount > 1000
                  ? Text('${(amount / 1000).toStringAsFixed(0)}K')
                  : Text('${amount.toStringAsFixed(0)} ₹'),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.02,
            ),
            Container(
              height: constraints.maxHeight * 0.60,
              width: 20,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).primaryColor),
                  ),
                  FractionallySizedBox(
                    heightFactor: 1 - pct,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                          color: Color.fromRGBO(230, 230, 230, 1),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: Text(day),
            ),
          ],
        );
      },
    );
  }
}
