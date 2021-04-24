// To parse this JSON data, do
//
//     final dbFuncs2 = dbFuncs2FromJson(jsonString);

import 'dart:convert';

DbFuncs2 dbFuncs2FromJson(String str) => DbFuncs2.fromJson(json.decode(str));

String dbFuncs2ToJson(DbFuncs2 data) => json.encode(data.toJson());

class DbFuncs2 {
  DbFuncs2({
    this.tables,
  });

  List<Table> tables;

  factory DbFuncs2.fromJson(Map<String, dynamic> json) => DbFuncs2(
        tables: List<Table>.from(json["tables"].map((x) => Table.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tables": List<dynamic>.from(tables.map((x) => x.toJson())),
      };
}

class Table {
  Table({
    this.id,
    this.tableId,
    this.productsId,
  });

  int id;
  int tableId;
  List<int> productsId;

  factory Table.fromJson(Map<String, dynamic> json) => Table(
        id: json["ID"],
        tableId: json["tableID"],
        productsId: List<int>.from(json["productsID"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "tableID": tableId,
        "productsID": List<dynamic>.from(productsId.map((x) => x)),
      };
}
