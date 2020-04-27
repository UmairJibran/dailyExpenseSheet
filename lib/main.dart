import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/services.dart';

import 'dart:async';

import './widgets/add_data.dart';
import './widgets/chart.dart';
import './models/data.dart';
import './widgets/data_list.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 500,
      child: Center(
        child: Text(
          "data",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> data = [];
  var preferences;
  @override
  void initState() {
    super.initState();
    _getData(
      Data(
        date: DateTime.now(),
        id: DateTime.now().toString(),
        itemName: "Test",
        itemPrice: 50,
      ),
    );
  }

  Future<bool> _getData(Data temp) async {
    preferences = await SharedPreferences.getInstance();
    // var temp = preferences.getDynamic('Key') ?? null;
    setState(() {
      data.add(temp);
    });
    return preferences.commit();
  }

  void _addData({
    @required String name,
    @required double price,
    @required DateTime myDate,
  }) {
    final Data dt = Data(
      itemPrice: price,
      date: myDate,
      id: DateTime.now().toString(),
      itemName: name,
    );
    _getData(dt);
    // setState(() {
    //   data.add(dt);
    // });
  }

  void _removeData(String idOfRemoving) {
    setState(() {
      data.removeWhere((tx) => tx.id == idOfRemoving);
    });
  }

  void _startAdditionOfNewData(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return AddData(_addData);
      },
    );
  }

  List<Data> get _userTx {
    return data.where((dt) {
      return dt.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var myAppBar = AppBar(
      title: Text("Expense Sheet"),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () => _startAdditionOfNewData(context),
        )
      ],
    );
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: (Platform.isIOS)
      //     ? FloatingActionButton(
      //         onPressed: () {},
      //       )
      //     : FloatingActionButton(
      //         mini: true,
      //         focusColor: Theme.of(context).accentColor,
      //         child: Icon(Icons.add),
      //         onPressed: () => _startAdditionOfNewData(context),
      //       ),
      appBar: myAppBar,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: (mediaQuery.size.height -
                        myAppBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.4,
                alignment: Alignment.center,
                child: Chart(_userTx),
              ),
              Container(
                child: DataList(data, _removeData),
                height: (mediaQuery.size.height -
                        myAppBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.6,
              ),
            ],
          ),
        ),
      ),
      // drawer: MyDrawer(),
    );
  }
}
