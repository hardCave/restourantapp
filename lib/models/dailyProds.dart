// To parse this JSON data, do
//
//     final dbFuncs1 = dbFuncs1FromJson(jsonString);

import 'dart:convert';

DbFuncs1 dbFuncs1FromJson(String str) => DbFuncs1.fromJson(json.decode(str));

String dbFuncs1ToJson(DbFuncs1 data) => json.encode(data.toJson());

class DbFuncs1 {
  DbFuncs1({
    this.dailyProds,
  });

  List<DailyProd> dailyProds;

  factory DbFuncs1.fromJson(Map<String, dynamic> json) => DbFuncs1(
        dailyProds: List<DailyProd>.from(
            json["DailyProds"].map((x) => DailyProd.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DailyProds": List<dynamic>.from(dailyProds.map((x) => x.toJson())),
      };
}

class DailyProd {
  DailyProd({
    this.id,
    this.productsCount,
    this.productId,
  });

  int id;
  int productsCount;
  int productId;

  factory DailyProd.fromJson(Map<String, dynamic> json) => DailyProd(
        id: json["ID"],
        productsCount: json["productsCount"],
        productId: json["productID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "productsCount": productsCount,
        "productID": productId,
      };
}
