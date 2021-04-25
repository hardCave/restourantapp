import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/productModel.dart';
import 'package:sqflite_demo/models/tablesModel.dart';
import 'package:sqflite_demo/screens/product_list.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class OrderAdd extends StatefulWidget {
  static const String routeName = "/orderaddpage";
  OrderAdd.withoutInfo();
  int masaNo;
  OrderAdd(masaNo) {
    this.masaNo = masaNo;
  }

  @override
  State<StatefulWidget> createState() {
    return _OrderAddState(masaNo);
  }
}

class _OrderAddState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();
  int masaNo = 0;
  List<currentProduct> addedProdList = List<currentProduct>();
  List<ProductsTable> zProdList = List<ProductsTable>();
  int count = 1;
  var map = Map<ProductsTable, int>();
  _OrderAddState(masaNo) {
    this.masaNo = masaNo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sipariş Al"),
        backgroundColor: Colors.deepOrange.shade800,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  margin: EdgeInsets.zero,
                  color: Colors.orange.shade800,
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
                          addedOrder(),
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
                  child: RaisedButton(
                    color: Colors.brown.shade500,
                    //sipariş al
                    onPressed: () {setState(() {

                      List<dynamic> liste = [];
                      var table = Tabless();
                      table.id = masaNo;
                      table.tableId = masaNo;
                      if (zProdList.isNotEmpty) {
                        for (int i = 0; i < zProdList.length; i++) {
                          liste.add(zProdList[i].productId);

                        }table.tableProducts = liste;
                      } else {
                        table.tableProducts = [];
                      }

                      dbhelper.insertTable(table);
                      zProdList.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ProductList.withoutInfo()),
                              (Route<dynamic> route) => false);

                    });},
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: SizedBox(
                  height: 49,
                  child: RaisedButton(
                    //ödeme al
                    onPressed: () {
                      setState(() {});
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
              child: Text("hata"),
            );
          } else if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.cyan,
                      elevation: 2.4,
                      child: ListTile(
                        title: Text(snapshot.data[position].productName
                                .toString() +
                            " " +
                            snapshot.data[position].productPrice.toString()),
                        onTap: () {
                          setState(() {
                            var zProd = ProductsTable();
                            zProd.productName =
                                snapshot.data[position].productName;
                            zProd.productPrice =
                                snapshot.data[position].productPrice;
                            zProd.productId = snapshot.data[position].productId;
                            zProdList.add(zProd);
                          });
                        },
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

  bubbleSort(List<ProductsTable> array) {
    int lengthOfArray = array.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (array[j].productName == array[j + 1].productName) {
          count += 1;
          map[array[j]] = count;
        }
      }
      count = 1;
      map[array[i]] = count;
    }
  }

  counter(List elements) {
    var map = Map<List<ProductsTable>, int>();

    elements.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });
  }

  addedOrder() {
    return Expanded(
      child: ListView.builder(
          itemCount: zProdList.length,
          itemBuilder: (BuildContext context, int pos) {
            return ListTile(
              title: Text(zProdList[pos].productName +
                  " " +
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

  colorSelect(pos) {
    if (pos % 2 == 0) {
      return Colors.black26;
    } else {
      return Colors.brown;
    }
  }
}
