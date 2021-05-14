import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/dailyProds.dart';
import 'package:sqflite_demo/models/productModel.dart';
import 'package:sqflite_demo/models/tablesModel.dart';
import 'package:sqflite_demo/screens/home_screen.dart';
import 'package:sqflite_demo/screens/product_list.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class OrderAdd extends StatefulWidget {
  static const String routeName = "/orderaddpage";
  OrderAdd.withoutInfo();
  bool caller = false;
  int masaNo;
  OrderAdd(masaNo) {
    this.masaNo = masaNo;
  }
  OrderAdd.fromListPage(masaNo, caller) {
    this.masaNo = masaNo;
    this.caller = caller;
  }

  @override
  State<StatefulWidget> createState() {
    return _OrderAddState.fromListPage(masaNo, caller);
  }
}

class _OrderAddState extends State {
  var table = Tabless();
  DatabaseHelper dbhelper = DatabaseHelper();
  bool caller = false;
  int masaNo;
  int count = 0;
  // ignore: deprecated_member_use
  List<ProductsTable> zProdList = List<ProductsTable>();
  // ignore: deprecated_member_use
  var degerim = List<ProductsTable>();
  var map = Map<ProductsTable, int>();
  _OrderAddState(masaNo) {
    this.masaNo = masaNo;
  }
  _OrderAddState.fromListPage(masaNo, caller) {
    this.masaNo = masaNo;
    this.caller = caller;
  }
  @override
  void initState() {
    fetchYapp();
    super.initState();
  }

  Future<void> fetchYapp() async {
    var temp = await validatorTable();
    setState(() {
      degerim = temp;
    });
  }

  //başyapıt
  Future<List<ProductsTable>> validatorTable() async {
    print("validatora girdi");
    //başyapıt
    Map<String, dynamic> mappp;
    var prTabList = await dbhelper.getProdList();
    var dbtab = await dbhelper.getTableswithId(masaNo);
    mappp = dbtab[0];
    var x = Tabless.fromJson(mappp);
    for (int i = 0; i < x.tableProducts.length - count; i++) {
      print("ilk for calıstı");
      for (int j = 0; j < prTabList.length; j++) {
        print("ikinci for ");
        if (x.tableProducts[i] == prTabList[j].productId) {
          zProdList.add(prTabList[j]);
          print(caller.toString() + " caller bu ");
          if (caller) {
            print("caller true geldi valid ici");
          }
        }
      }
    }
    return zProdList;
  }

  getStat() {
    if (caller) {
      return addedOrderyeni();
    } else {
      return addedOrdereski();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sipariş Al"),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.all(10),
                  //color: Colors.purple,
                  width: 240,
                  height: 630,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      defaultProducts(),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    Container(
                      width: 160,
                      height: 630,
                      color: Colors.orange.shade200,
                      child: Column(
                        children: [
                          getStat(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 6,
                child: SizedBox(
                  height: 49,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    color: Colors.brown.shade500,
                    //sipariş al
                    onPressed: () {
                      setState(() {
                        List<dynamic> liste = [];
                        if (zProdList.isNotEmpty && !caller) {
                          table.id = masaNo;
                          table.tableId = masaNo;
                          for (int i = 0; i < zProdList.length; i++) {
                            liste.add(zProdList[i].productId);
                          }
                          table.tableProducts = liste;
                          dbhelper.insertTable(table, masaNo);
                        } else {
                          table.id = masaNo;
                          table.tableId = masaNo;
                          for (int i = 0; i < degerim.length; i++) {
                            liste.add(degerim[i].productId);
                          }
                          table.tableProducts = liste;
                          print(table.tableProducts);
                          dbhelper.insertTable(table, masaNo);
                        }
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen()),
                            (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: SizedBox(
                  height: 49,
                  child: RaisedButton(
                    color: Colors.deepOrange,
                    //ödeme al
                    onPressed: () {
                      setState(() {
                        dailyCreate(masaNo);
                        dbhelper.deleteTable(masaNo);
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen()),
                            (Route<dynamic> route) => false);
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  defaultProducts() {
    return FutureBuilder<List<ProductsTable>>(
        future: dbhelper.getProdList(),
        builder: (context, AsyncSnapshot<List<ProductsTable>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("hatajhkjhkjhkj"),
            );
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int position) {

                    return Container(
                      margin: EdgeInsets.all(7),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.deepPurple.shade200,
                        elevation: 2.4,
                        child: ListTile(
                          title: Text(snapshot.data[position].productName
                                  .toString() +
                              " " +
                              snapshot.data[position].productPrice.toString()),
                          onTap: () {
                            setState(() {
                              zProd.productName =
                                  snapshot.data[position].productName;
                              zProd.productPrice =
                                  snapshot.data[position].productPrice;
                              zProd.productId =
                                  snapshot.data[position].productId;
                              zProdList.add(zProd);
                            });
                          },
                        ),
                      ),
                    );
                  }),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("else girdi");
          }
        });
  }

  addedOrdereski() {
    print("eskiadded calıstı");
    return Expanded(
      child: ListView.builder(
          itemCount: zProdList.length,
          itemBuilder: (BuildContext context, int pos) {
            return ListTile(
              title: Text(zProdList[pos].productName +
                  " dsfsdf" +
                  zProdList[pos].productPrice.toString() +
                  "₺"),
              onTap: () {
                setState(() {
                  zProdList.removeAt(pos);
                });
              },
            );
          }),
    );
  }

  addedOrderyeni() {
    print("yeniadded calıstı");
    return Expanded(
      child: ListView.builder(
          itemCount: degerim.length,
          itemBuilder: (BuildContext context, int pos) {
            return ListTile(
              title: Text(degerim[pos].productName +
                  " " +
                  degerim[pos].productPrice.toString() +
                  "₺"),
              onTap: () {
                setState(() {
                  count++;
                  degerim.removeAt(pos);
                });
              },
            );
          }),
    );
  }

  void dailyCreate(int massa) async{
    var liste = await dbhelper.getTableList();

    var listee = liste[massa].tableProducts;
    table.tableProducts = listee;
    print(table.tableProducts);
    int a = 0;
    int count = 0;
      for (int i = 0; i<listee.length; i++){
        if (listee[a] == listee[i]){
          count++;
        }
        else{
          var dProd = DailyProd();
          dProd.id = null;
          dProd.productId = a;
          dProd.productsCount = count;
          dbhelper.insertDaily(dProd);
          a = table.tableProducts[i];
          count = 1;
        }
    }
  }
  /*addedOrder() {
    return FutureBuilder<List<ProductsTable>>(
        future: validatorTable(),
        builder: (context, AsyncSnapshot<List<ProductsTable>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "hata" + zProdList.length.toString() + zProdList.toString()),
            );
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int pos) {
                    return ListTile(
                      title: Text(snapshot.data[pos].productName +
                          " " +
                          snapshot.data[pos].productPrice.toString() +
                          "₺"),
                      onTap: () {
                        setState(() {
                          snapshot.data.removeAt(pos);
                          dbhelper.deleteTable(pos);
                        });
                      },
                    );
                  }),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Text("else girdi");
          }
        });
  }
  }*/
}
