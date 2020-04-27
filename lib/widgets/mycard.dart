import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCard extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final DateTime date;
  final Function deleteFtn;
  MyCard({this.id, this.date, this.name, this.deleteFtn, this.price});

  @override
  Widget build(BuildContext context) {
    final String priceSt = "Rs. ${price.toStringAsFixed(2)}";
    final String dateSt = DateFormat.yMMMMEEEEd().format(date);
    return Card(
      elevation: 1,
      child: ListTile(
        leading: Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black38,
              width: 2,
            ),
          ),
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                priceSt,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.title,
          // style: TextStyle(
          //   color: Theme.of(context).accentColor,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        subtitle: Text(
          dateSt,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => deleteFtn(id),
        ),
      ),
      // Row(
      //   children: <Widget>[
      //     Container(
      //         height: 50,
      //         width: 100,
      //         decoration: BoxDecoration(
      //           border: Border.all(
      //             color: Theme.of(context).primaryColor,
      //             width: 2,
      //             style: BorderStyle.solid,
      //           ),
      //         ),
      //         margin: EdgeInsets.symmetric(
      //           horizontal: 15,
      //           vertical: 20,
      //         ),
      //         padding: EdgeInsets.all(10),
      //         child: Center(
      //           child: FittedBox(
      //             child: Text(
      //               "Rs. ${price.toStringAsFixed(2)}",
      //               style: TextStyle(
      //                 color: Theme.of(context).accentColor,
      //               ),
      //             ),
      //           ),
      //         )),
      //     Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Text(
      //           name,
      //           style: Theme.of(context).textTheme.title,
      //         ),
      //         Text(
      //           DateFormat.yMMMMEEEEd().format(date),
      //         ),
      //       ],
      //     ),
      //     // Column(
      //     //   crossAxisAlignment: CrossAxisAlignment.end,
      //     //   children: <Widget>[
      //     //     // Padding(
      //     //     //   padding: EdgeInsets.only(left: 100),
      //     //     // ),
      //     //     Text("Delete"),
      //     //     Text("Icon"),
      //     //   ],
      //     // )
      //   ],
      // ),
    );
  }
}
