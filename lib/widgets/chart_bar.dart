import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  String amount;
  String weekDay;
  double percentage;

  ChartBar(this.amount, this.weekDay, this.percentage);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weekDay),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        Text(amount),
        //Text(percentage.toString())
      ],
    );
  }
}