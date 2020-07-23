import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final double amountSpent;
  final double pctSpent;

  ChartBar(this.weekDay, this.amountSpent, this.pctSpent);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var avaiHei = constraint.maxHeight;
      print('Now available Height : ${avaiHei.toStringAsFixed(2)}');
      return Column(
        children: <Widget>[
          Container(
            height: avaiHei * 0.15,
            child: FittedBox(
              child: Text('\$${amountSpent.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: avaiHei * 0.03,
          ),
          Container(
            height: avaiHei * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: pctSpent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: avaiHei * 0.03,
          ),
          Container(
            height: avaiHei * 0.13,
            child: FittedBox(
              child: Text(
                '$weekDay',
              ),
            ),
          ),
        ],
      );
    });
  }
}
