import 'package:flutter/material.dart';

import '../widgets/mycard.dart';
import '../models/data.dart';

class DataList extends StatelessWidget {
  final List<Data> data;
  final Function ft;

  DataList(this.data, this.ft);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: data.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      "No Data Yet",
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.5,
                        child: Image.asset(
                          "assets/images/waiting.png",
                          fit: BoxFit.cover,
                        )),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return MyCard(
                  date: data[index].date,
                  id: data[index].id,
                  name: data[index].itemName,
                  price: data[index].itemPrice,
                  deleteFtn: ft,
                );
              },
              itemCount: data.length,
            ),
    );
  }
}
