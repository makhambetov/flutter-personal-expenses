import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  final Function submitHandler;

  NewTransaction(this.submitHandler);

  void submit() {
    String title = titleController.text;
    String amount = amountController.text;

    if(amount.isNotEmpty && title.isNotEmpty && double.parse(amount) > 0) {

      double amountDouble = double.parse(amount);

      submitHandler(title, amountDouble);
    }
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
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              onSubmitted: (_) => submit(),
            ),
            FlatButton(
              onPressed: submit,
              child: Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}
