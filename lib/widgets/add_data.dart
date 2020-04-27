import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddData extends StatefulWidget {
  final add;
  AddData(this.add);
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;
  void submitData() {
    final enteredAmount = amountController.text;
    final enteredTitle = titleController.text;
    if (selectedDate == null) {
      setState(() {
        selectedDate = DateTime.now();
      });
    }
    widget.add(
      name: enteredTitle,
      price: double.parse(enteredAmount),
      myDate: selectedDate,
    );

    Navigator.of(context).pop();
  }

  void dateChoosing() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Card(
            elevation: 10,
            child: Column(
              children: <Widget>[
                TextField(
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  cursorColor: Colors.blue,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Name of the Item",
                  ),
                  controller: titleController,
                  // onSubmitted: (_) => submitData(),
                ),
                TextField(
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                    labelText: "Price of the Item",
                  ),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  // onSubmitted: (_) => submitData(),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    left: 15.0,
                    right: 15.0,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(selectedDate == null
                          ? "No Date Chosen"
                          : DateFormat.yMMMd().format(selectedDate)),
                      FlatButton(
                        child: Text(
                          "Select Date",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onPressed: dateChoosing,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: submitData,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
