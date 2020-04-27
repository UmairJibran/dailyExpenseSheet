import 'package:flutter/foundation.dart';

class Data {
  DateTime date;
  String itemName;
  double itemPrice;
  String id;

  Data({
    @required this.date,
    @required this.id,
    @required this.itemName,
    @required this.itemPrice,
  });
}
