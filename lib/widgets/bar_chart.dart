import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double amountSpending;
  final double amountInPerc;
  BarChart(this.label, this.amountSpending, this.amountInPerc);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(
              child: Text(
                'Rs ${amountSpending.toStringAsFixed(0)}',
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.7,
            width: 15,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: (1 - amountInPerc),
                  child: Container(
                      width: 15,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.grey,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.04,
          ),
          Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(
              child: Text(
                label,
              ),
            ),
          ),
        ],
      );
    });
  }
}
