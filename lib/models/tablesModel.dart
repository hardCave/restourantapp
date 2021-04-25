// To parse this JSON data, do
//
//     final dbFuncs1 = dbFuncs1FromJson(jsonString);

import 'dart:convert';

DbFuncs1 dbFuncs1FromJson(String str) => DbFuncs1.fromJson(json.decode(str));

String dbFuncs1ToJson(DbFuncs1 data) => json.encode(data.toJson());

class DbFuncs1 {
  DbFuncs1({
    this.tabless,
  });

  List<Tabless> tabless;

  factory DbFuncs1.fromJson(Map<String, dynamic> json) => DbFuncs1(
    tabless: List<Tabless>.from(json["Tabless"].map((x) => Tabless.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Tabless": List<dynamic>.from(tabless.map((x) => x.toJson())),
  };
}

class Tabless {
  Tabless({
    this.id,
    this.tableId,
    this.tableProducts,
  });

  int id;
  int tableId;
  List<dynamic> tableProducts;

  factory Tabless.fromJson(Map<String, dynamic> json) => Tabless(
    id: json["ID"],
    tableId: json["tableID"],
    tableProducts: List<dynamic>.from(json["tableProducts"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "tableID": tableId,
    "tableProducts": List<dynamic>.from(tableProducts.map((x) => x)),
  };
}
