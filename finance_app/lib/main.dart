import 'package:finance_app/model/transaction.dart';
import 'package:finance_app/widgets/chart_transaction.dart';
import 'package:finance_app/widgets/new_transaction.dart';
import 'package:finance_app/widgets/transactionlist.dart';
import 'package:flutter/material.dart';

void main() {
  //Delgets ergehgui baih tohirgoo
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        errorColor: Colors.red,
        fontFamily: 'OpenSans',
        // textButtonTheme: TextButtonThemeData(
        //     style: TextButton.styleFrom(
        //         primary: Colors.red,
        //         textStyle: const TextStyle(
        //             fontSize: 24,
        //             fontWeight: FontWeight.bold,
        //             fontStyle: FontStyle.italic))),
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
          toolbarTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
              .bodyText2,
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.amber),
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

  bool _showChart = false;
  List<Widget> _buildLandscapeContent(Widget chart, Widget list) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Харуулах"),
          Switch(
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              }),
        ],
      ),
      _showChart ? chart : list
    ];
  }

  List<Widget> _buildPortail(
      MediaQueryData mediaQuery, AppBar appBar, double height, Widget list) {
    return [
      Container(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            height,
        child: ChartTransaction(transaction: _recentTransactions),
      ),
      list,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final islanscape = mediaQuery.orientation == Orientation.landscape;
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

    final list = Container(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: TransactionList(
        transaction: userTransaction,
        removed: removeTransaction,
      ),
    );

    final chart = Container(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          (islanscape ? 0.7 : 0.3),
      child: ChartTransaction(transaction: _recentTransactions),
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (islanscape) ..._buildLandscapeContent(chart, list),
            if (!islanscape)
              ..._buildPortail(
                  mediaQuery, appBar, (islanscape ? 0.7 : 0.3), list),
          ],
        ),
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
