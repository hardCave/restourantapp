// To parse this JSON data, do
//
//     final dbFuncs = dbFuncsFromJson(jsonString);

import 'dart:convert';

DbFuncs dbFuncsFromJson(String str) => DbFuncs.fromJson(json.decode(str));

String dbFuncsToJson(DbFuncs data) => json.encode(data.toJson());

class DbFuncs {
  DbFuncs({
    this.reportZ,
  });

  List<ReportZ> reportZ;

  factory DbFuncs.fromJson(Map<String, dynamic> json) => DbFuncs(
        reportZ:
            List<ReportZ>.from(json["reportZ"].map((x) => ReportZ.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reportZ": List<dynamic>.from(reportZ.map((x) => x.toJson())),
      };
}

class ReportZ {
  ReportZ({
    this.id,
    this.dateOfReport,
    this.productsId,
  });

  int id;
  String dateOfReport;
  List<int> productsId;

  factory ReportZ.fromJson(Map<String, dynamic> json) => ReportZ(
        id: json["ID"],
        dateOfReport: json["dateOfReport"],
        productsId: List<int>.from(json["productsID"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "dateOfReport": dateOfReport,
        "productsID": List<dynamic>.from(productsId.map((x) => x)),
      };
}
