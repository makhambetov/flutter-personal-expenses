import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _removeHandler;

  TransactionList(this.transactions, this._removeHandler);

  void _showAlertModal(String id, context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text('Are you sure?')),
        elevation: 5,
        actions: <Widget>[
          FlatButton(
            child: Text('YES'),
            onPressed: () {
              _removeHandler(id);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('CANCELL'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, idx) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: FittedBox(
                        child: Text(transactions[idx].amount.toString())),
                  ),
                ),
                title: Text(
                  transactions[idx].title,
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[idx].date),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () =>
                      _showAlertModal(transactions[idx].id, context),
                  color: Theme.of(context).errorColor,
                )),
          );
        },
      ),
    );
  }
}
