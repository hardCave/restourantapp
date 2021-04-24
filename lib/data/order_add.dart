import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/allProducts.dart';
import 'package:sqflite_demo/data/newData.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/orders.dart';
import 'package:sqflite_demo/models/productModel.dart';
import 'package:sqflite_demo/models/reportModel.dart';
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
  List<ProductsTable> crProductList = List<ProductsTable>();
  List<currentProduct> addedProdList = List<currentProduct>();
  List<ProductsTable> zProdList = List<ProductsTable>();
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
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ProductList.withoutInfo()),
                          (Route<dynamic> route) => false);
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
                    //ödeme al
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /*defaultProductsEski() {
    var keys = allProducts.getDefaultProducts().keys.toList();
    var valuess = allProducts.getDefaultProducts().values.toList();
    int index = 10;
    return Expanded(
      child: ListView.builder(
          itemCount: index,
          itemBuilder: (BuildContext context, int pos) {
            return ListTile(
              tileColor: colorSelect(pos),
              leading: Icon(Icons.add),
              selectedTileColor: Colors.orange.shade400,
              title: Text(keys[pos] + "  " + valuess[pos].toString() + "₺"),
            );
          }),
    );
  }*/

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
                            var crProd = ProductsTable();
                            var zProd = ProductsTable();
                            zProd.productName =
                                snapshot.data[position].productName;
                            zProd.productPrice =
                                snapshot.data[position].productPrice;
                            zProdList.add(zProd);
                            crProd.productName =
                                snapshot.data[position].productName;
                            crProd.productPrice =
                                snapshot.data[position].productPrice;
                            crProductList.add(crProd);
                            bubbleSort(crProductList);
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
      int count = 1;
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (array[j].productName == array[j + 1].productName) {
          // Swapping using temporary variable
          count++;
          array[j].productName = addedProdList[j].product;
          addedProdList[j].price = array[j].productPrice;
          addedProdList[j].adet = count;
          j += 1;
        }
      }
      if (count == 1) {
        addedProdList[i].product = array[i].productName;
        addedProdList[i].price = array[i].productPrice;
        addedProdList[i].adet = 1;
      }
    }
  }

  addedOrder() {
    return Expanded(
      child: ListView.builder(
          itemCount: addedProdList.length,
          itemBuilder: (BuildContext context, int pos) {
            return ListTile(
              title: Text(addedProdList[pos].adet.toString() +
                  " Ad " +
                  addedProdList[pos].product +
                  " " +
                  (addedProdList[pos].price * addedProdList[pos].adet)
                      .toString() +
                  "₺"),
              onTap: () {
                setState(() {
                  if (addedProdList[pos].adet > 1) {
                    for (int i = 0; i < crProductList.length; i++) {
                      if (crProductList[i].productName ==
                          addedProdList[pos].product) {
                        crProductList.removeAt(i);
                      }
                    }
                    addedProdList[pos].adet -= 1;
                  } else {
                    for (int i = 0; i < crProductList.length; i++) {
                      if (crProductList[i].productName ==
                          addedProdList[pos].product) {
                        crProductList.removeAt(i);
                      }
                    }
                    addedProdList.removeAt(pos);
                  }
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
