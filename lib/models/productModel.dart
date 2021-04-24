// To parse this JSON data, do
//
//     final dbFuncs1 = dbFuncs1FromJson(jsonString);

import 'dart:convert';

DbFuncs1 dbFuncs1FromJson(String str) => DbFuncs1.fromJson(json.decode(str));

String dbFuncs1ToJson(DbFuncs1 data) => json.encode(data.toJson());

class DbFuncs1 {
  DbFuncs1({
    this.productsTable,
  });

  List<ProductsTable> productsTable;

  factory DbFuncs1.fromJson(Map<String, dynamic> json) => DbFuncs1(
        productsTable: List<ProductsTable>.from(
            json["productsTable"].map((x) => ProductsTable.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productsTable":
            List<dynamic>.from(productsTable.map((x) => x.toJson())),
      };
}

class ProductsTable {
  ProductsTable({
    this.productId,
    this.productName,
    this.productPrice,
  });

  int productId;
  String productName;
  double productPrice;

  factory ProductsTable.fromJson(Map<String, dynamic> json) => ProductsTable(
        productId: json["productID"],
        productName: json["productName"],
        productPrice: json["productPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "productID": productId,
        "productName": productName,
        "productPrice": productPrice,
      };
}
