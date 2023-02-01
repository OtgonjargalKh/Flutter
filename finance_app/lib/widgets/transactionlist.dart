import 'package:finance_app/widgets/list.dart';
import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'nodata.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String)? removed;
  const TransactionList({super.key, required this.transaction, this.removed});

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? const NoDataFound()
        : ListWithdraw(transaction, removed);
  }
}
