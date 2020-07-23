import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

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
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    child: ListTile(
                      leading: Container(
                        //padding: EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                        child: CircleAvatar(
                          radius: 40,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                '\$${_transactionlist[index].amount.toStringAsFixed(2)}',
                                //style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        _transactionlist[index].title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(_transactionlist[index].date),
                      ),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              onPressed: () =>
                                  deleteTransaction(_transactionlist[index].id),
                              icon: Icon(Icons.delete),
                              label: Text("Delete"),
                              textColor: Theme.of(context).errorColor,
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () =>
                                  deleteTransaction(_transactionlist[index].id),
                              color: Theme.of(context).errorColor,
                            ),
                    ),
                  );
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
