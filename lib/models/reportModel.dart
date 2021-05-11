// To parse this JSON data, do
//
//     final dbFuncs1 = dbFuncs1FromJson(jsonString);

import 'dart:convert';

DbFuncs1 dbFuncs1FromJson(String str) => DbFuncs1.fromJson(json.decode(str));

String dbFuncs1ToJson(DbFuncs1 data) => json.encode(data.toJson());

class DbFuncs1 {
  DbFuncs1({
    this.reportZ,
  });

  List<ReportZ> reportZ;

  factory DbFuncs1.fromJson(Map<String, dynamic> json) => DbFuncs1(
    reportZ: List<ReportZ>.from(json["ReportZ"].map((x) => ReportZ.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ReportZ": List<dynamic>.from(reportZ.map((x) => x.toJson())),
  };
}

class ReportZ {
  ReportZ({
    this.id,
    this.productsText,
    this.dateYear,
    this.dateMonth,
    this.dateDay,
  });

  int id;
  String productsText;
  int dateYear;
  int dateMonth;
  int dateDay;

  factory ReportZ.fromJson(Map<String, dynamic> json) => ReportZ(
    id: json["ID"],
    productsText: json["productsText"],
    dateYear: json["dateYear"],
    dateMonth: json["dateMonth"],
    dateDay: json["dateDay"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "productsText": productsText,
    "dateYear": dateYear,
    "dateMonth": dateMonth,
    "dateDay": dateDay,
  };
}