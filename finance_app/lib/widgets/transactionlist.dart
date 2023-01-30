import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(Transaction)? removed;
  const TransactionList({super.key, required this.transaction, this.removed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transaction.isEmpty
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
                  child: Image.asset('assets/images/folder.png',
                      fit: BoxFit.cover),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "\$ : ${transaction[index].amount.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction[index].title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transaction[index].date),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          removed!(transaction[index]);
                        },
                        tooltip: 'Increment',
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
              itemCount: transaction.length,
              // children: transaction.map((tx) {
              //   return
              // }).toList(),
            ),
    );
  }
}
