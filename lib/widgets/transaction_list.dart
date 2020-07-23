import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactionlist;
  final Function deleteTransaction;

  TransactionList(this._transactionlist, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        // color: Colors.white,
        height: 450,
        child: _transactionlist.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    'No Transactions added yet!!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                    height: 200,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: _transactionlist.length,
                itemBuilder: (context, index) {
                  return TransactionItem(transaction: _transactionlist[index], deleteTransaction: deleteTransaction);
                })
        // : ListView(
        //     children: _transactionlist
        //         .map((tx) => Card(
        //               child: Row(
        //                 children: <Widget>[
        //                   Container(
        //                     child: Text(
        //                       '\$${tx.amount.toStringAsFixed(2)}',
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.purple[400],
        //                       ),
        //                     ),
        //                     margin: EdgeInsets.symmetric(
        //                         vertical: 10, horizontal: 15),
        //                     decoration: BoxDecoration(
        //                       border: Border.all(
        //                           color: Theme.of(context).primaryColor,
        //                           width: 2,
        //                           style: BorderStyle.solid),
        //                     ),
        //                     padding: EdgeInsets.all(5),
        //                   ),
        //                   Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       Container(
        //                         child: Text(
        //                           tx.title,
        //                           style:
        //                               Theme.of(context).textTheme.headline5,
        //                         ),
        //                       ),
        //                       Container(
        //                         child: Text(
        //                           DateFormat().format(tx.date),
        //                           style: TextStyle(
        //                             color: Colors.grey,
        //                           ),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                 ],
        //               ),
        //               elevation: 10,
        //             ))
        //         .toList(),
        //   ),
        );
  }
}

