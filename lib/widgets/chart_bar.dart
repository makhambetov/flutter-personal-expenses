import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String amount;
  final String weekDay;
  final double percentage;

  ChartBar(this.amount, this.weekDay, this.percentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                child: Text(amount),
              ),
            ),
            SizedBox(height: constraints.maxHeight * .05),
            Container(
              height: constraints.maxHeight * .60,
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
            SizedBox(height: constraints.maxHeight * .05),
            Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(
                child: Text(weekDay),
              ),
            ),
          ],
        );
      },
    );
  }
}
