import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _dateChosen;

  void submitted() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _dateChosen == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _dateChosen,
    );
    Navigator.of(context).pop();

    print('Title: ' + enteredTitle);
    print('Amount is : \$$enteredAmount');
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.parse('2020-01-01'),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _dateChosen = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => submitted(),
              ),
              const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      _dateChosen == null
                          ? 'No Date chosen!'
                          : 'Picked Date: ${DateFormat.yMMMd().format(_dateChosen)}',
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FlatButton(
                    onPressed: _datePicker,
                    child: Text(
                      'Choose Date!',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: new FractionalOffset(0.94, 0),
                child: RaisedButton(
                  child: const Text('Add Transaction'),
                  onPressed: submitted,
                  //color: Colors.blue[50],
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
