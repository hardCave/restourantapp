import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/allProducts.dart';
import 'package:sqflite_demo/models/orders.dart';

class OrderAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderAddState();
  }
}

class _OrderAddState extends State {
  var allProducts = AllProducts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sipariş Al"),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  defaultProducts(),
                  Text("data") //Mevcut ürünler
                ],
              ),
              Row(
                children: [
                  Column(
                      //Masadaki Ürünler
                      ),
                  Column(
                      // Toplam tutar
                      ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text("data") //Siparis al butonu
            ],
          ),
          Row(
            children: [
              Text("data") //Ödeme al butonu
            ],
          ),
        ],
      ),
    );
  }

  ListView defaultProducts() {

    return ListView.builder(
        itemCount: 10,
        //itembuilder elemanları tek tek dolaşan bir for döngüsü gibi çalışiyor
        itemBuilder: (BuildContext context, int position) {
          return ListTile(
            subtitle: Text(allProducts.getDefaultProducts().values[0]),
            onTap: () {},
          );
        });
  }
}
