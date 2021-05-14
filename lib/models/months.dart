// To parse this JSON data, do
//
//     final dbFuncs1 = dbFuncs1FromJson(jsonString);

import 'dart:convert';

DbFuncs1 dbFuncs1FromJson(String str) => DbFuncs1.fromJson(json.decode(str));

String dbFuncs1ToJson(DbFuncs1 data) => json.encode(data.toJson());

class DbFuncs1 {
  DbFuncs1({
    this.months,
  });

  List<Month> months;

  factory DbFuncs1.fromJson(Map<String, dynamic> json) => DbFuncs1(
    months: List<Month>.from(json["months"].map((x) => Month.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "months": List<dynamic>.from(months.map((x) => x.toJson())),
  };
}

class Month {
  Month({
    this.id,
    this.month,
    this.year,
  });

  int id;
  int month;
  int year;

  factory Month.fromJson(Map<String, dynamic> json) => Month(
    id: json["ID"],
    month: json["month"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "month": month,
    "year": year,
  };
}
