import 'package:flutter/material.dart';
import 'file:///C:/Users/yucel/Desktop/uygulamalar/sqflite_demo/lib/screens/Masalar.dart';
import 'package:sqflite_demo/data/order_add.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/screens/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: ProductList.withoutInfo(),
    );
  }
}
