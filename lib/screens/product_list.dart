import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/allProducts.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/data/order_add.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/screens/Masalar.dart';

class ProductList extends StatefulWidget {
  //
  static const String routeName = "/productlistpage";
  var crProductList = List<currentProduct>();
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
  var crProductList = List<currentProduct>();
  int masaNo;
  var allPro = AllProducts();
  var tempProdList = List<String>();
  var tableStack = List<int>();
  var urunmap = Map<int, String>();
  int cont = 0;
  var keys;
  var values;

  _ProductListState(crProductList, masaNo) {
    this.crProductList = crProductList;
    this.masaNo = masaNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ürün Listesi")),
      body: statusCheck(masaNo,urunmap),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToMasalar();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  statusCheck(int masaNooo,urunler) {
    if (tableStack == null && masaNooo == null) {
      print("status null");
      return null;
    } else {
      String tempProdString = "";
      if (crProductList.isNotEmpty) {
        for (int i = 0; i < crProductList.length; i++) {
          tempProdString += crProductList[i].product +
              " " +
              this.crProductList[i].adet.toString() +
              "Ad.";
        }

        cont++;
      }
      urunler[masaNooo] = tempProdString;

      this.tempProdList.add(tempProdString);
      print(tempProdList.last);
      print(tempProdList.first);
      print(tableStack.toString() + tableStack.toString());
      return buildProductList(keys,values);
    }
  }

  ListView buildProductList(keys,values) {
    keys = urunmap.keys.toList();
    values = urunmap.values.toList();
    return ListView.builder(
        itemCount: urunmap.length,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.cyan,
            elevation: 2.4,
            child: ListTile(
              title: Text("Masa " + keys[position].toString() + " " + urunmap.length.toString()),
              subtitle: Text(values[position]),
            ),
          );
        });
  }

  int itemCounter(List tabs, List crpo) {
    if (tableStack.isEmpty) {
      print("a");
      return 0;
    } else if (tabs.isNotEmpty && (crpo.last == " " + "Ad.")) {
      print("b");
      tabs.removeAt(tabs.length);
      crpo.removeAt(crpo.length);
      return tabs.length - 1;
    } else {
      print("c");
      return tabs.length;
    }
  }

  void goToMasalar() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Masalar()),
        (Route<dynamic> route) => true);
  }
}
