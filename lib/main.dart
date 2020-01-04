import 'package:flutter/material.dart';

import './widgets/new_transactions.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: TextTheme(
          button: TextStyle(
              color: Colors.white
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
      id: 'tx-1',
      title: 'iPhone 11',
      amount: 100,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'tx-3',
      title: 'iPhone 11',
      amount: 500,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'tx-2',
      title: 'Nike',
      amount: 400,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(
            days: 7,
          ),
        ),
      );
    }).toList();
  }

  void _addTx(String txTitle, double txAmount, DateTime date) {
    Transaction newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      id: DateTime.now().toString(),
      date: date,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _removeTx(int idx) {
    setState(() {
      _userTransactions.removeAt(idx);
    });
  }

  void _openAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addTx),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openAddNewTransaction(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Chart(_recentTransactions),
              _userTransactions.isNotEmpty
                  ? TransactionList(_userTransactions, _removeTx)
                  : emptyTx()
            ],
          ),
        ),
      ),
    );
  }

  Container emptyTx() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            'No transactions',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Image.asset(
            'assets/images/no_txs.png',
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
