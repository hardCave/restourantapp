import 'package:flutter/material.dart';
import 'package:sqflite_demo/screens/product_update_2.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class UpdateScreen extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UpdateScreenState();
  }
}

titleReturn(String text, x, String font, double fontsize) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: font,
        fontSize: fontsize,
        color: x,
      ),
    ),
  );
}

class _UpdateScreenState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title:
            titleReturn("Ürün Ekle ve Güncelle", Colors.white, "Raleway", 24),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: uListBuilder(),
    );
  }

  uListBuilder() {
    return Column(
      children: [
        Flexible(
          flex: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(10),
            //color: Colors.purple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int position) {
                        return Container(
                            margin: EdgeInsets.all(7),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.deepPurple.shade200,
                              elevation: 5,
                              child: ListTile(
                                contentPadding: EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                onTap: () {
                                  createAlertDialog(context);
                                },
                                title: Text("Tavuk Tantuni",
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.deepPurple.shade600)),
                                subtitle: Text("10₺",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(fontSize: 24)),
                              ),
                            ));
                      }),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => UpdateScreenSecond()),
                  (Route<dynamic> route) => true);
            },
            splashColor: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(52),
            child: Container(
              child: Card(
                color: Colors.deepPurple.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: SizedBox(
                    height: 50,
                    width: 230,
                    child:
                        titleReturn("Yeni Ürün", Colors.white, "Raleway", 24)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

createAlertDialog(BuildContext context) {
  TextEditingController customController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(31.0)),
            title: Text("Ürün Güncelleme",
                style: TextStyle(
                    color: Colors.deepPurple.shade500,
                    fontFamily: "Raleway",
                    fontSize: 24)),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Sil',
                    style: TextStyle(
                        color: Colors.deepPurple.shade500,
                        fontFamily: "Raleway",
                        fontSize: 20)),
                onPressed: () {},
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text('Güncelle',
                    style: TextStyle(
                        color: Colors.deepPurple.shade500,
                        fontFamily: "Raleway",
                        fontSize: 20)),
                onPressed: () {},
              )
            ]);
      });
}
