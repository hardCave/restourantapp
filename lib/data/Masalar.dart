import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Masalar extends StatefulWidget {
  String masaNo = "MASA ";
  String masaUrunler = "Masa Boş";
  bool masaDurum = false;

  @override
  State<StatefulWidget> createState() {
    return _MasalarState();
  }
}

class _MasalarState extends State {
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
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.brown,
                child: ,

              );
            }),
      ),
    );
  }
}
