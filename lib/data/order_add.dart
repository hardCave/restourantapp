import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/allProducts.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/orders.dart';

class OrderAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderAddState();
  }
}

class _OrderAddState extends State {

 List crProductList =  List();
  @override
  void initState() {
    defaultProducts();
    addedOrder();
  }


  var allProducts = AllProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sipariş Al"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 6,
                child: Container(
                  margin: EdgeInsets.zero,
                  color: Colors.redAccent,
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
                      color: Colors.black26,
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
                    //sipariş al
                    onPressed: () {},
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
              title: Text(keys[pos] + "  " + valuess[pos].toString() + "₺"),
              onTap: () {setState(() {
                var crProd = currentProduct();
                crProd.price = valuess[pos];
                crProd.product = keys[pos];
                crProductList.add(crProd);
              });
              },
            );
          }),
    );
  }
  addedOrder() {

     return Expanded(
       child: ListView.builder(
          itemCount: crProductList.length,
          itemBuilder: (BuildContext context, int pos) {
            return ListTile(
              title: Text(crProductList[pos].price.toString() + " " + crProductList[pos].product),
              onTap: (){
                setState(() {
                });
              },
            );
          }),
     );
  }

}
