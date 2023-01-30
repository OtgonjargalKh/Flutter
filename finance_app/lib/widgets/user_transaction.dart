import 'package:flutter/material.dart';
import '../model/transaction.dart';
import './transactionlist.dart';

class UserTransactions extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(Transaction)? removed;
  const UserTransactions({
    super.key,
    required this.transaction,
    required this.removed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(
          transaction: transaction,
          removed: removed,
        ),
      ],
    );
  }
}
