import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String)? removed;
  const TransactionList({super.key, required this.transaction, this.removed});

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? Column(
            children: [
              const Text(
                'Одоогоор мэдээлэл байхгүй',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                child:
                    Image.asset('assets/images/folder.png', fit: BoxFit.cover),
              ),
            ],
          )
        : ListView.builder(
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
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
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
