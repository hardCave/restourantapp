import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/productModel.dart';
import 'package:sqflite_demo/models/tablesModel.dart';
import 'package:sqflite_demo/screens/Masalar.dart';
import 'package:sqflite_demo/screens/order_add.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class ProductList extends StatefulWidget {
  //

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
    return Scaffold(backgroundColor: Colors.deepPurple.shade100,
      appBar: AppBar(title: Text("Ürün Listesi"),backgroundColor: Colors.deepPurple.shade300,),
      body: buildFutureBuilder(),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.deepPurple.shade500,
        onPressed: () {
          goToMasalar();
        },
        child: Icon(Icons.add,color: Colors.white,size: 30,),
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
                    color: Colors.white,
                    elevation: 2.4,
                    child: ListTile(
                      title:
                      Text("Masa " + (snapshot.data[position].id +1).toString(),style: TextStyle(fontFamily: "Raleway",fontSize: 22),textAlign: TextAlign.end,),
                      subtitle: Deneme(snapshot.data[position]),
                      onTap: () {
                        int hangimasa = snapshot.data[position].id;
                        var routeCaller = true;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderAdd.fromListPage(
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

    liste.tableProducts.sort();
    var tekst = "";
    var pmap = List<List>();

    //default map olustur
    for(int i = 0;i<listee.length;i++){
      var list = List();
      list.add(listee[i].productId);
      list.add(0);
      pmap.add(list);
    }

    for(int i = 0;i<liste.tableProducts.length;i++){
      for(int j = 0;j<pmap.length;j++){
        if (liste.tableProducts[i] == pmap[j][0]){
          pmap[j][1]++;
        }
      }
    }

    for(int i = 0;i<pmap.length;i++){
      if(pmap[i][1]!=0){
        tekst += pmap[i][1].toString() + " ad. " + listee[i].productName + "\n";
      }
    }
    return Text(tekst,style: TextStyle(fontFamily: "Raleway",fontSize: 18,color: Colors.black,height: 1.3));
  }

  void goToMasalar() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Masalar()),
            (Route<dynamic> route) => true);
  }
}