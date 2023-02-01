import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class ListWithdraw extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String)? removed;

  const ListWithdraw(this.transaction, this.removed, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text(
                    '\$${transaction[index].amount}',
                  ),
                ),
              ),
            ),
            title: Text(
              '${transaction[index].title}',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(transaction[index].date),
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            trailing: MediaQuery.of(context).size.width > 420
                ? TextButton.icon(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    label: const Text(
                      'Устгах',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    onPressed: () {
                      removed!(transaction[index].id);
                    },
                  )
                : IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () {
                      removed!(transaction[index].id);
                    },
                  ),
          ),
        );
      },
      itemCount: transaction.length,
      // children: transaction.map((tx) {
      //   return
      // }).toList(),
    );
  }
}
