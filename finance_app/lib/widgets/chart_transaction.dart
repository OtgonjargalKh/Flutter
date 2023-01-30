import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';
import 'chartitem.dart';

class ChartTransaction extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(Transaction)? removed;
  const ChartTransaction({super.key, required this.transaction, this.removed});

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var total = 0.0;

      for (var tx in transaction) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          total += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': total
      };
    }).reversed.toList();
  }

  double get totalSpend {
    return groupedTransactionValues.fold(0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartItem(
                tx['day'] as String,
                tx['amount'] as double,
                totalSpend == 0 ? 0 : (tx['amount'] as double) / totalSpend,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
