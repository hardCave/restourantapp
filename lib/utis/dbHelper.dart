import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
      print("Creating new copy from asset");

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
      print("Opening existing database");
    }
// open the database
    _db = await openDatabase(path, readOnly: false);
    return _db;
  }

  Future<List<Map<String, dynamic>>> getDefProd() async {
    Database db = await _getDatabase();
    var result2 = await db.query("productsTable");
    return result2;
  }
  Future<List<ProductsTable>> getProdList()async{
    var dbprod = await getDefProd();
    var defprods = List<ProductsTable>();
    for (Map map in dbprod){
      defprods.add(ProductsTable.fromJson(map));
    }
    return defprods;
  }

  Future<int> insertPr(ProductsTable prTable) async {
    Database db = await _getDatabase();
    var result = await db.insert("products", prTable.toJson());
    return result;
  }

  Future<int> deletePr(int productId) async {
    Database db = await _getDatabase();
    var result = await db
        .delete("products", where: 'productID = ?', whereArgs: [productId]);
    return result;
  }

  Future<int> updatePr(ProductsTable prTable) async {
    Database db = await _getDatabase();
    var result = await db.update("products", prTable.toJson(),
        where: 'productID = ?', whereArgs: [prTable.productId]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getTables() async {
    Database db = await _getDatabase();
    var result2 = await db.query("tables");
    return result2;
  }
  Future<List<Tabless>> getTableList()async{
    var dbtab = await getTables();
    var defprods = List<Tabless>();
    for (Map map in dbtab){
      defprods.add(Tabless.fromJson(map));
    }
    return defprods;
  }

  Future<int> insertTable(Tabless tables) async {
    Database db = await _getDatabase();
    var result = await db.insert("tables", tables.toJson());
    return result;
  }

  Future<int> deleteTable(int id) async {
    Database db = await _getDatabase();
    var result = await db.delete("tables", where: 'ID = ?', whereArgs: [id]);
    return result;
  }

  Future<int> updateTable(Tabless table) async {
    Database db = await _getDatabase();
    var result = await db.update("products", table.toJson(),
        where: 'productID = ?', whereArgs: [table.id]);
    return result;
  }

  Future<List<Map<String, dynamic>>> getReport() async {
    Database db = await _getDatabase();
    var result2 = await db.query("reportZ");
    return result2;
  }

  Future<int> insertZ(ReportZ z) async {
    Database db = await _getDatabase();
    var result = await db.insert("reportZ", z.toJson());
    return result;
  }

  /*Future<int> deleteZ(int productId ) async { // tamamlanmadı
    Database db = await _getDatabase();
    var result = await db.delete("products", where:  'productID = ?', whereArgs:[productId]);
    return result;
  }*/

  /*Future<int> updateZ(ProductsTable prTable) async { // tamamlanmadı
    Database db = await _getDatabase();
    var result = await db.update("products", prTable.toJson(), where:  'productID = ?', whereArgs:[prTable.productId] );
    return result;
  }*/

}
