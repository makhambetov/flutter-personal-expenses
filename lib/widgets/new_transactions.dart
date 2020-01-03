import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function submitHandler;

  NewTransaction(this.submitHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _pickedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      setState(() {
        _pickedDate = date;
      });
    });
  }

  void submit() {
    String title = _titleController.text;
    String amount = _amountController.text;

    if (amount.isNotEmpty && title.isNotEmpty && double.parse(amount) > 0) {
      double amountDouble = double.parse(amount);

      widget.submitHandler(title, amountDouble);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              onSubmitted: (_) => submit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _pickedDate == null
                          ? 'No date picked'
                          : 'Picked date: ${DateFormat.yMMMd().format(_pickedDate)}',
                    ),
                  ),
                  FlatButton(
                    child: Text('Chose date'),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: submit,
              child: Text('Add transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
