import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/yucel/Desktop/uygulamalar/sqflite_demo/lib/screens/order_add.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/productModel.dart';
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
  Future urunler;
  int cont = 0;
  var listee = List<ProductsTable>();
  DatabaseHelper dbhelper = DatabaseHelper();

  @override
  void initState() {
    fetchYap();
    super.initState();
  }

  Future<void> fetchYap() async {
    var temp = await getListOfProducts();
    setState(() {
      listee = temp;
    });
  }

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
        //heplerList(),
        builder: (context, AsyncSnapshot<List<Tabless>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("hata"),
            );
          } else if (snapshot.hasData) {
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
                      title:
                          Text("Masa " + snapshot.data[position].id.toString()),
                      subtitle: Deneme(snapshot.data[position]),
                      onTap: () {
                        int hangimasa = snapshot.data[position].id;
                        var routeCaller = true;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => OrderAdd.fromListPage(
                                    hangimasa, routeCaller)),
                            (Route<dynamic> route) => true);
                      },
                    ),
                  );
                });
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("else girdi");
          }
        });
  }

  Future<List<ProductsTable>> getListOfProducts() async {
    var urunList = await dbhelper.getProdList();
    var urunler = urunList;
    if (urunler != null) {
      return urunler;
    }
  }

  Deneme(Tabless liste) {
    int count = 0;
    var abc = List();
    var tekst = "";
    for (int j = 0; j < liste.tableProducts.length; j++) {
      for (int a = 0; a < listee.length; a++) {
        if (liste.tableProducts[j] == listee[a].productId) {
          abc.add(listee[a].productName);
        }
      }
    }
    for (int i = 0; i < abc.length; i++) {
      count = 1;
      for (int j = 0; j < abc.length - i - 1; j++) {
        if (abc[j] == abc[j + 1]) {
          count++;
          abc[j] += " " + count.toString() + "Ad ";
          abc.removeAt(j + 1);
        }
      }
      if (count == 1) {
        abc[i] += " " + count.toString() + "Ad ";
      }
      count = 1;
    }
    for (int i = 0; i < abc.length; i++) {
      tekst += abc[i];
    }
    return Text(tekst);
  }

  void goToMasalar() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Masalar()),
        (Route<dynamic> route) => true);
  }
}
