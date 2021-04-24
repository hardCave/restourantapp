import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/order_add.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class Masalar extends StatefulWidget {
  int masaNo;
  bool masaDurum = false;

  @override
  State<StatefulWidget> createState() {
    return _MasalarState();
  }
}

class _MasalarState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Masalar"),
      ),
      body: Container(
        child: GridView.builder(
            itemCount: 40,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemBuilder: (BuildContext context, int pos) {
              return Card(
                color: Colors.brown,
                child: ListTile(
                  title: Text("Masa ${pos + 1}"),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        OrderAdd(pos+1)), (Route<dynamic> route) => true);
                  },
                ),
              );
            }),
      ),
    );
  }
}
