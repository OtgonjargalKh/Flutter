import 'package:finance_app/model/transaction.dart';
import 'package:finance_app/widgets/new_transaction.dart';
import 'package:finance_app/widgets/transactionlist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleInput;
  final List<Transaction> userTransaction = [
    // Transaction(
    //   id: "one",
    //   amount: 20.2,
    //   title: "cook",
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "two",
    //   amount: 20.2,
    //   title: "clothes",
    //   date: DateTime.now(),
    // ),
  ];

  void addTransaction(String title, double amount) {
    final newItem = Transaction(
      id: DateTime.now().toString(),
      amount: amount,
      date: DateTime.now(),
      title: title,
    );
    setState(() {
      userTransaction.add(newItem);
    });
  }

  void add(
    BuildContext ctx,
  ) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addTransaction);
        });
  }

  void rempoveTransaction(Transaction item) {
    setState(() {
      userTransaction.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        textTheme: Theme.of(context).appBarTheme.textTheme,
        title: const Text("Flutter app"),
        actions: <Widget>[
          IconButton(
            onPressed: () => add(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                Card(
                  child: Text("Chart"),
                  color: Colors.blue,
                  elevation: 10,
                ),
              ],
            ),
          ),
          TransactionList(
            transaction: userTransaction,
            removed: rempoveTransaction,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
