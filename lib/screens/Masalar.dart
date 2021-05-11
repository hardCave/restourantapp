import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/yucel/Desktop/uygulamalar/sqflite_demo/lib/screens/order_add.dart';
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
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int pos) {
              return Card(
                elevation: 50,
                color: Colors.brown,
                child: ListTile(
                  tileColor: Colors.white,
                  title: Text("Masa ${pos + 1}"),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        OrderAdd.fromListPage(pos,false)), (Route<dynamic> route) => true);
                  },
                ),
              );
            }),
      ),
    );
  }
}
