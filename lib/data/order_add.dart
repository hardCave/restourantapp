import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/allProducts.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/screens/product_list.dart';

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
  int masaNo;
  List crProductList = List<currentProduct>();

  _OrderAddState(masaNo) {
    this.masaNo = masaNo;
  }

  var allProducts = AllProducts();
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
                              builder: (context) =>
                                  ProductList(crProductList, masaNo)),
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

  defaultProducts() {
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
              onTap: () {
                setState(() {
                  var crProd = currentProduct();
                  crProd.price = valuess[pos];
                  crProd.product = keys[pos];
                  crProd.adet = 1;
                  crProductList.add(crProd);
                  crProductList = bubbleSort(crProductList);
                });
              },
            );
          }),
    );
  }

  bubbleSort(List<currentProduct> array) {
    int lengthOfArray = array.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (array[j].product == array[j + 1].product) {
          // Swapping using temporary variable
          array[j].adet += 1;
          array.removeAt(j + 1);
        }
      }
    }
    return (array);
  }

  addedOrder() {
    return Expanded(
      child: ListView.builder(
          itemCount: crProductList.length,
          itemBuilder: (BuildContext context, int pos) {
            return ListTile(
              title: Text(crProductList[pos].adet.toString() +
                  " Ad " +
                  crProductList[pos].product +
                  " " +
                  (crProductList[pos].price * crProductList[pos].adet)
                      .toString() +
                  "₺"),
              onTap: () {
                setState(() {
                  if (crProductList[pos].adet > 1) {
                    crProductList[pos].adet -= 1;
                  } else {
                    crProductList.removeAt(pos);
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
