import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double, DateTime)? addTransactionItem;

  const NewTransaction(this.addTransactionItem, {super.key});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  ///Ustgagch func
  @override
  void dispose() {
    super.dispose();
  }

  void _submiteData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        _selectedDate == null ||
        double.parse(amountController.text) <= 0) {
      return;
    }
    final inputTitle = titleController.text;
    final inputAmount = double.parse(amountController.text);
    widget.addTransactionItem!(
      inputTitle,
      inputAmount,
      _selectedDate!,
    );
    Navigator.of(context).pop();
  }

  void _presentPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: "Зарлага"),
                controller: titleController,
                onSubmitted: ((_) => _submiteData()),
                style: Theme.of(context).textTheme.titleMedium,
                // onChanged: (val) => titleInput = val,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Дүн"),
                controller: amountController,
                keyboardType: TextInputType.number,
                style: Theme.of(context).textTheme.titleMedium,
                onSubmitted: ((_) => _submiteData()),
                // onChanged: (val) => amountInput = val,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Ognoo songogdoogui"
                          : 'Огноо : ${DateFormat.yMd().format(_selectedDate!)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _presentPicker,
                    child: const Text(
                      "Огноо сонгох",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _submiteData,
                  child: const Text(
                    "Зарлага нэмэх",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
