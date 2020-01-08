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
          button: TextStyle(color: Colors.white),
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
      title: 'Video Game',
      amount: 100,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 'tx-2',
      title: 'iPhone',
      amount: 500,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'tx-3',
      title: 'New T-shirt',
      amount: 400,
      date: DateTime.now(),
    ),
  ];

  bool _showChart = false;

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

  void _removeTx(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
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
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    var appBar = AppBar(
      title: Text('Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openAddNewTransaction(context),
        ),
      ],
    );

    var bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;

    Container txListWidget = Container(
      height: bodyHeight * .7,
      child: _userTransactions.isNotEmpty
          ? TransactionList(_userTransactions, _removeTx)
          : emptyTx(),
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Show chart'),
                    Switch(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      },
                    ),
                  ],
                ),
              if (!isLandscape) chart(bodyHeight * .3),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _showChart ? chart(bodyHeight * .7) : txListWidget
            ],
          ),
        ),
      ),
    );
  }

  Widget emptyTx() {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
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
          Container(
            height: constraints.maxHeight * .6,
            child: Image.asset(
              'assets/images/no_txs.png',
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    });
  }

  Container chart(double height) {
    return Container(
      height: height,
      child: Chart(_recentTransactions),
    );
  }
}
