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
    helper = DbHelper2();
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
        future: getCrProdd(),
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

  Future<List<currentProduct>> getCrProdd() async {
    var orderList = await helper.getCrProd();
    // ignore: deprecated_member_use
    var crProds = List<currentProduct>();
    if (orderList.isNotEmpty){
      print(orderList.length);
      print(orderList[1].id.toString() + "bu");
      for (int i = 0; i < 1; i++)helper.deleteCr(i);
      for (int i = 0; i < orderList.length; i++) {
        if (orderList[i].tavukSomun != 0 || orderList[i].tavukSomun !=null){
          crProds[i].product +=
              "tavuk somun" + orderList[i].tavukSomun.toString() + " Ad.";
        }
        if (orderList[i].etSomun != 0|| orderList[i].etSomun != null) {
         crProds[i].product += "et somun " + orderList[i].etSomun.toString() + " Ad.";
        }
        if (orderList[i].tavuk != 0 || orderList[i].tavuk !=null) {
          crProds[i].product =
              "Ta" + orderList[i].tavuk.toString() + " Ad.";
        }
        if (orderList[i].et != 0|| orderList[i].et != null) {
          crProds[i].product = "Tav" + orderList[i].et.toString() + " Ad.";
        }
        if (orderList[i].etYogurt != 0|| orderList[i].etYogurt != null) {
          crProds[i].product =
              "Tavu" + orderList[i].etYogurt.toString() + " Ad.";
        }
        if (orderList[i].tavukYogurt != 0|| orderList[i].tavukYogurt != null) {
          crProds[i].product =
              "Tavuk  " + orderList[i].tavukYogurt.toString() + " Ad.";
        }
        if (orderList[i].ayran != 0|| orderList[i].ayran != null) {
          crProds[i].product =
              "Tavuk S " + orderList[i].ayran.toString() + " Ad.";
        }
        if (orderList[i].kola != 0|| orderList[i].kola != null) {
          crProds[i].product =
              "Tavuk So " + orderList[i].kola.toString() + " Ad.";
        }
        if (orderList[i].su != 0||orderList[i].su != null ) {
          crProds[i].product = "Tavuk Som " + orderList[i].su.toString() + " Ad.";
        }
        if (orderList[i].salgam != 0||orderList[i].salgam != null ) {
          crProds[i].product =
              "Tavuk Somu " + orderList[i].salgam.toString() + " Ad.";
        }
        crProds[i].price = double.tryParse(orderList[i].masaNo.toString());
      }
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
