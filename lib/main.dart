import 'package:flutter/material.dart';

import './widgets/user_input.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';
import './models/available_pixels.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App Project',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        //accentColor: Colors.amber,
        backgroundColor: Colors.white,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1',
        title: "New Shoes",
        amount: 69.99,
        date: DateTime.parse('2020-07-17')),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.parse('2020-07-15'),
    ),
    Transaction(
        id: 't3',
        title: "Random Expenses",
        amount: 10.54,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(
        id: 'Long',
        title: 'Long Expense',
        amount: 78,
        date: DateTime.parse('2020-07-16')),
    Transaction(
        id: 't4', title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 't9',
        title: "Random Expenses",
        amount: 10.54,
        date: DateTime.now().subtract(Duration(days: 3))),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(
        days: 7,
      )));
    }).toList();
  }

  void addNewInList(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(addNewInList);
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void deleteAll() {
    setState(() {
      _userTransactions.removeRange(0, _userTransactions.length - 1);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Expense Tracker'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(context),
          color: Colors.white,
          //highlightColor: Colors.grey,
        )
      ],
    );
    final avaiHei = MediaQuery.of(context).size.height -
        (appBar.preferredSize.height + MediaQuery.of(context).padding.top);
    print('Available Height: $avaiHei px');
    availableHeight = avaiHei;

    bool isLandscape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Show Chart'),
                  Switch(
                      value: _showChart,
                      onChanged: (newValue) {
                        setState(() {
                          _showChart = newValue;
                        });
                      }),
                ],
              ),
            if (isLandscape)
              _showChart
                  ? SizedBox(
                      child: Chart(_recentTransactions),
                      height: avaiHei * 0.7,
                    )
                  //NewTransaction(addNewInList),
                  : SizedBox(
                      height: avaiHei * 0.7,
                      child:
                          TransactionList(_userTransactions, deleteTransaction),
                    ),
            if (!isLandscape)
              SizedBox(
                child: Chart(_recentTransactions),
                height: avaiHei * 0.3,
              ),
            //NewTransaction(addNewInList),
            if (!isLandscape)
              SizedBox(
                height: avaiHei * 0.7,
                child: TransactionList(_userTransactions, deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
