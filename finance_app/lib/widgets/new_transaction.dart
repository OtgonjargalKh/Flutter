import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double)? addTransactionItem;

  const NewTransaction(this.addTransactionItem, {super.key});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submiteData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        double.parse(amountController.text) <= 0) {
      return;
    }
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);
    widget.addTransactionItem!(
      inputTitle,
      inputAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          TextField(
            decoration: const InputDecoration(labelText: "Зарлага"),
            controller: titleController,
            onSubmitted: ((_) => submiteData()),
            // onChanged: (val) => titleInput = val,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Дүн"),
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: ((_) => submiteData()),
            // onChanged: (val) => amountInput = val,
          ),
          ElevatedButton(
            onPressed: submiteData,
            child: const Text(
              "Зарлага нэмэх",
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
