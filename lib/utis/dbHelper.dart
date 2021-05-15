import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/dailyProds.dart';
import 'package:sqflite_demo/models/months.dart';
import 'package:sqflite_demo/models/productModel.dart';
import 'package:sqflite_demo/models/reportModel.dart';
import 'package:sqflite_demo/models/tablesModel.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }
  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initilazeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initilazeDatabase() async {
    Database _db;

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "appDB.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      // print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "dosyadi.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      //print("Opening existing database");
    }
// open the database
    _db = await openDatabase(path, readOnly: false);
    return _db;
  }
//-------------------------------------------------------PRODUCT SECTION------------------------------//
  Future<List<Map<String, dynamic>>> getDefProd() async {
    Database db = await _getDatabase();
    var result2 = await db.query("productsTable");
    return result2;
  }

  Future<List<ProductsTable>> getProdList() async {
    var dbprod = await getDefProd();
    var defprods = List<ProductsTable>();
    for (Map map in dbprod) {
      defprods.add(ProductsTable.fromJson(map));
    }
    return defprods;
  }

  Future<int> insertPr(ProductsTable prTable) async {
    Database db = await _getDatabase();
    var result = await db.insert("productsTable", prTable.toJson());
    return result;
  }

  Future<int> deletePr(int productId) async {
    Database db = await _getDatabase();
    var result = await db
        .delete("productsTable", where: 'productID = ?', whereArgs: [productId]);
    return result;
  }

  Future<int> updatePr(ProductsTable prTable) async {
    Database db = await _getDatabase();
    var result = await db.update("productsTable", prTable.toJson(),
        where: 'productID = ?', whereArgs: [prTable.productId]);
    return result;
  }
//-------------------------------------------------------PRODUCTS SECTION------------------------------//
//-------------------------------------------------------TABLE SECTION------------------------------//
  Future<List<Map<String, dynamic>>> getTables() async {
    Database db = await _getDatabase();
    var result2 = await db.query("tables");
    return result2;
  }

  Future<List<Map<String, dynamic>>> getTableswithId(int id) async {
    Database db = await _getDatabase();
    var result2 = await db.query("tables", where: "ID = ?", whereArgs: [id]);
    return result2;
  }

  Future<List<Tabless>> getTableList() async {
    var dbtab = await getTables();
    var defprods = List<Tabless>();
    for (Map map in dbtab) {
      defprods.add(Tabless.fromJson(map));
    }
    return defprods;
  }

  Future<int> insertTable(Tabless tables, int id) async {
    Database db = await _getDatabase();
    var defProds = List<Tabless>();
    defProds = await getTableList();
    if (defProds.any((element) => element.id == tables.id)) {
      var result = await db.update("tables", tables.toJson(),
          where: 'tableID = ?', whereArgs: [tables.id]);
      return result;
    } else {
      var result = await db.insert("tables", tables.toJson());
      return result;
    }
  }

  Future<int> deleteTable(int id) async {
    Database db = await _getDatabase();
    var result = await db.delete("tables", where: 'ID = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateTable(Tabless table) async {
    Database db = await _getDatabase();
    var result = await db.update("tables", table.toJson(),
        where: 'productID = ?', whereArgs: [table.id]);
    return result;
  }
//-------------------------------------------------------TABLE SECTION-------------------------------//
//-------------------------------------------------------REPORT SECTION-------------------------------//
  Future<List<Map<String, dynamic>>> getReport() async {
    Database db = await _getDatabase();
    var result2 = await db.query("reportZ");
    return result2;
  }
  Future<List<Map<String, dynamic>>> getReportByMonth(int month, int year) async {
    Database db = await _getDatabase();
    var result2 = await db.query("reportZ",where: "dateYear=$year AND dateMonth=$month");
    return result2;
  }
  Future<List<ReportZ>> getReportByMonthList(int month,int year) async {
    var dbtab = await getReportByMonth(month, year);
    var defprods = List<ReportZ>();
    for (Map map in dbtab) {
      defprods.add(ReportZ.fromJson(map));
    }
    return defprods;
  }
  Future<List<Map<String, dynamic>>> getReportByDay(int month, int year,int day) async {
    Database db = await _getDatabase();
    var result2 = await db.query("reportZ",where: "dateYear=$year AND dateMonth=$month AND dateDay=$day");
    return result2;
  }
  Future<List<ReportZ>> getReportByDayList(int month,int year,int day) async {
    var dbtab = await getReportByDay(month,year,day);
    var defprods = List<ReportZ>();
    for (Map map in dbtab) {
      defprods.add(ReportZ.fromJson(map));
    }
    return defprods;
  }

  Future<int> insertZ(ReportZ z) async {
    Database db = await _getDatabase();
    var result = await db.insert("reportZ", z.toJson());
    return result;
  }

  Future<int> deleteZ(int productId) async {
    Database db = await _getDatabase();
    var result =
        await db.delete("ReportZ", where: 'ID = ?', whereArgs: [productId]);
    return result;
  }

  Future<int> updateZ(ReportZ z) async {
    Database db = await _getDatabase();
    var result = await db.update("ReportZ", z.toJson(),
        where: 'ID = ?', whereArgs: [z.id]);
    return result;
  }
//-------------------------------------------------------REPORT SECTION--------------------------------------//
//-------------------------------------------------------DAILY SECTION---------------------------------------//
  Future<List<Map<String, dynamic>>> getDaily() async {
    Database db = await _getDatabase();
    var result2 = await db.query("daily");
    return result2;
  }

  Future<List<DailyProd>> getDailyList() async {
    var dbDaily = await getDaily();
    var dailyProd = List<DailyProd>();
    for (Map map in dbDaily) {
      dailyProd.add(DailyProd.fromJson(map));
    }
    return dailyProd;
  }

  Future<int> deleteDaily(int productId) async {
    // tamamlanmadı
    Database db = await _getDatabase();
    var result = await db.delete("daily");
    return result;
  }

  Future<int> insertDaily(DailyProd dProd) async {
    Database db = await _getDatabase();
    var defProds = List<DailyProd>();
    defProds = await getDailyList();
    if (defProds.any((element) => element.id == dProd.id)) {
      var result = await db.update("daily", dProd.toJson(),
          where: 'ID = ?', whereArgs: [dProd.id]);
      return result;
    } else {
      var result = await db.insert("daily", dProd.toJson());
      return result;
    }
  }
  Future<int> updateDaily(DailyProd d) async {
    Database db = await _getDatabase();
    var result = await db.update("daily", d.toJson(),
        where: 'ID = ?', whereArgs: [d.id]);
    return result;
  }
//-------------------------------------------------------DAILY SECTION-------------------------------------//
  //-------------------------------------------------------MONTH SECTION-------------------------------------//
  Future<List<Map<String, dynamic>>> getMonths() async {
    Database db = await _getDatabase();
    var result2 = await db.query("months");
    return result2;
  }
  Future<List<Month>> getMonthList() async {
    var dbMonth = await getMonths();
    var m = List<Month>();
    for (Map map in dbMonth) {
      m.add(Month.fromJson(map));
    }
    return m;
  }

  Future<int> insertM(Month m) async {
    Database db = await _getDatabase();
    var defProds = List<Month>();
    defProds = await getMonthList();
    if (!(defProds.any((element) => element.year == m.year && element.month == m.month))) {
      var result = await db.insert("months", m.toJson());
      return result;
    }
  }

  Future<int> deleteM(int id) async {
    Database db = await _getDatabase();
    var result =
    await db.delete("months", where: 'ID = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateM(Month m) async {
    Database db = await _getDatabase();
    var result = await db.update("months", m.toJson(),
        where: 'ID = ?', whereArgs: [m.id]);
    return result;
  }
//-------------------------------------------------------MONTH SECTION-------------------------------------//
}
