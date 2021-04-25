import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/tablesModel.dart';
import 'package:sqflite_demo/screens/Masalar.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class ProductList extends StatefulWidget {
  //
  static const String routeName = "/productlistpage";
  Future crProductList;
  int masaNo;
  ProductList.withoutInfo();
  //
  ProductList(crProductList, masaNo) {
    this.crProductList = crProductList;
    this.masaNo = masaNo;
  }

  @override
  State<StatefulWidget> createState() {
    return _ProductListState(crProductList, masaNo);
  }
}

class _ProductListState extends State {
  //
  Future<List<currentProduct>> crProductList;
  int masaNo;
  int cont = 0;
  DatabaseHelper dbhelper = DatabaseHelper();

  _ProductListState(crProductList, masaNo) {
    this.crProductList = crProductList;
    this.masaNo = masaNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ürün Listesi")),
      body: buildFutureBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToMasalar();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  buildFutureBuilder() {
    return FutureBuilder<List<Tabless>>(
        future: dbhelper.getTableList(),
        builder: (context,AsyncSnapshot<List<Tabless>> snapshot) {
          if (snapshot.hasError){
            return Center(
              child: Text("hata"),
            );}
          else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int position) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.cyan,
                    elevation: 2.4,
                    child: ListTile(
                      title: Text("Masa " +
                          snapshot.data[position].id.toString()),
                      subtitle: Text(snapshot.data[position].tableProducts.toString() + " asdfşlasldfşs ürünler asdklsdf"),
                    ),
                  );
                });
          } else if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return Text("else girdi");
          }
        });
  }

  void goToMasalar() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Masalar()),
        (Route<dynamic> route) => true);
  }


}
