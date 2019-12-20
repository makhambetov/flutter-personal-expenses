import 'package:a1/models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 'tx-1',
      title: 'iPhone 11',
      amount: 500000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'tx-2',
      title: 'Nike',
      amount: 40000,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Card(
            child: Text('Chart'),
          ),
        ),
        body: Column(
          children: <Widget>[
            Card(
              child: Text('Tx1'),
            ),
            Card(
              child: Text('Tx2'),
            ),
          ],
        ),
      ),
    );
  }
}
