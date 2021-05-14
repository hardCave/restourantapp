import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

import 'order_add.dart';

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
    var size = MediaQuery.of(context).size;
    var cardTextStyle = TextStyle(
        fontFamily: "Raleway",
        fontSize: 24,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        centerTitle: true,
        title: Text(
          "Masalar",
          textAlign: TextAlign.center,
          style: cardTextStyle,
        ),
      ),
      body: Container(
        color: Colors.deepPurple.shade50,
        padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Container(
          child: GridView.builder(
              itemCount: 39,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              ),
              itemBuilder: (BuildContext context, int pos) {
                return InkWell(
                  splashColor: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(52),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                OrderAdd.fromListPage(pos, false)),
                        (Route<dynamic> route) => true);
                  },
                  child: Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(31)),
                      elevation: 7,
                      margin: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 13,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.only(
                                bottom: 8.5,
                                top: 8.5,
                                right: 8.5,
                                left: 8.5,
                              ),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/tables.png'))),
                              child: Text(' '),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 3,
                            child: SizedBox(
                              child: Text(
                                'MASA ' + (pos + 1).toString(),
                                //style: cardTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
