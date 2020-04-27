import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_sheet/widgets/bar_chart.dart';

import '../models/data.dart';

class Chart extends StatelessWidget {
  final List<Data> recentTX;

  Chart(this.recentTX);

  List<Map<String, Object>> get groupedTxV {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSpent = 0.0;
      for (var i = 0; i < recentTX.length; i++) {
        if (recentTX[i].date.day == weekDay.day &&
            recentTX[i].date.month == weekDay.month &&
            recentTX[i].date.year == weekDay.year) {
          totalSpent += recentTX[i].itemPrice;
        }
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "price": totalSpent,
      };
    }).reversed.toList();
  }

  double get totalSpent {
    return groupedTxV.fold(0.0, (sum, it) {
      return sum + it['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      elevation: 10,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTxV.map(
              (dt) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: BarChart(
                    dt['day'],
                    dt['price'],
                    totalSpent == 0.0
                        ? 0.0
                        : (dt['price'] as double) / totalSpent,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
