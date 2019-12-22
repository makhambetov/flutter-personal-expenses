import 'package:flutter/material.dart';

import './new_transactions.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
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

  void _addTx(String txTitle, double txAmount) {
    Transaction newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      id: DateTime.now().toString(),
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addTx),
        TransactionList(_userTransactions),
      ],
    );
  }
}
