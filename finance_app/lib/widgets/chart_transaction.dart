import 'package:flutter/material.dart';
import '../model/transaction.dart';

class ChartTransaction extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(Transaction)? removed;
  const ChartTransaction({super.key, required this.transaction, this.removed});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
