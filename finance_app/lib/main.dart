import 'package:finance_app/model/transaction.dart';
import 'package:finance_app/widgets/chart_transaction.dart';
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
        errorColor: Colors.red,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 18,
            color: Colors.black,
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

  List<Transaction> get _recentTransactions {
    return userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addTransaction(String title, double amount, DateTime choosenDate) {
    final newItem = Transaction(
      id: DateTime.now().toString(),
      amount: amount,
      date: choosenDate,
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

  void removeTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((tx) => tx.id == id);
      // userTransaction.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      textTheme: Theme.of(context).appBarTheme.textTheme,
      title: const Text("Flutter app"),
      actions: <Widget>[
        IconButton(
          onPressed: () => add(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    appBar.preferredSize.height) *
                0.28,
            child: ChartTransaction(transaction: _recentTransactions),
          ),
          Container(
            height: (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    appBar.preferredSize.height) *
                0.7,
            child: TransactionList(
              transaction: userTransaction,
              removed: removeTransaction,
            ),
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
