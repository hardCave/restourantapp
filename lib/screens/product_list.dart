import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/allProducts.dart';
import 'package:sqflite_demo/data/newData.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/orders.dart';
import 'package:sqflite_demo/screens/Masalar.dart';

class ProductList extends StatefulWidget {
  //
  static const String routeName = "/productlistpage";
  Future crProductList; //= List<currentProduct>()
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
  var allPro = AllProducts();
  var tempProdList = List<String>();
  var tableStack = List<int>();
  var urunmap = Map<int, String>();
  var order = List<Order>();
  int cont = 0;
  DbHelper2 helper = DbHelper2();

  _ProductListState(crProductList, masaNo) {
    this.crProductList = crProductList;
    this.masaNo = masaNo;
  }
  @override
  void initState() {
    getCrProd();
    super.initState();
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
    return FutureBuilder<List<currentProduct>>(
        future: getCrProd(),
        builder: (context,AsyncSnapshot<List<currentProduct>> snapshot) {
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
                          int.tryParse(snapshot.data[position].price.toString())
                              .toString()),
                      subtitle: Text(snapshot.data[position].product),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  /*statusCheck(int masaNooo, urunler) {
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
      return buildProductList();
    }
  }*/

  Future<List<currentProduct>> getCrProd() async {
    var order = await helper.getCrProd();
    var crProds = List<currentProduct>();
    var pcr = currentProduct(adet: 0,price: 0,product: " ");
    crProds.add(pcr);
    if (order.isNotEmpty){

      print("tertemiz");
      for (int i = 0; i < order.length; i++) {
        if (order[i].tavukSomun != null) {
          print(crProds[i].product =
              "T" + order[i].tavukSomun.toString() + " Ad.");
        }
        if (order[i].etSomun != null) {
          print(crProds[i].product = "mun " + order[i].etSomun.toString() + " Ad.");
        }
        if (order[i].tavuk != null) {
          crProds[i].product =
              "Ta" + order[i].tavuk.toString() + " Ad.";
        }
        if (order[i].et != null) {
          crProds[i].product = "Tav" + order[i].et.toString() + " Ad.";
        }
        if (order[i].etYogurt != null) {
          crProds[i].product =
              "Tavu" + order[i].etYogurt.toString() + " Ad.";
        }
        if (order[i].tavukYogurt != null) {
          crProds[i].product =
              "Tavuk  " + order[i].tavukYogurt.toString() + " Ad.";
        }
        if (order[i].ayran != null) {
          crProds[i].product =
              "Tavuk S " + order[i].ayran.toString() + " Ad.";
        }
        if (order[i].kola != null) {
          crProds[i].product =
              "Tavuk So " + order[i].kola.toString() + " Ad.";
        }
        if (order[i].su != null) {
          crProds[i].product = "Tavuk Som " + order[i].su.toString() + " Ad.";
        }
        if (order[i].salgam != null) {
          crProds[i].product =
              "Tavuk Somu " + order[i].salgam.toString() + " Ad.";
        }
        crProds[i].price = double.tryParse(order[i].masaNo.toString());
        order[i].masaNo = this.masaNo;
        order[i].saat = DateTime.now();

      }
    }
    else{
    }
    print("qqqqqqqqqqqqqq");
    return crProds;
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
