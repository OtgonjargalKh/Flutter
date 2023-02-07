import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class ListWithdraw extends StatefulWidget {
  final Transaction transaction;
  final void Function(String)? removed;

  const ListWithdraw({
    required Key key,
    required this.transaction,
    required this.removed,
  }) : super(key: key);

  @override
  State<ListWithdraw> createState() => _ListWithdrawState();
}

class _ListWithdrawState extends State<ListWithdraw> {
  Color? _colors;
  @override
  void initState() {
    const ableColors = [
      Colors.red,
      Colors.green,
      Colors.orange,
    ];
    _colors = ableColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _colors,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount}',
              ),
            ),
          ),
        ),
        title: Text(
          '${widget.transaction.title}',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
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
                  widget.removed!(widget.transaction.id);
                },
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () {
                  widget.removed!(widget.transaction.id);
                },
              ),
      ),
    );

    // children: transaction.map((tx) {
    //   return
    // }).toList(),
  }
}
