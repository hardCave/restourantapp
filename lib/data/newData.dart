import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/currentProducts.dart';
import 'package:sqflite_demo/models/orders.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper2 {
  Database _db;
  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "crProd.db");
    var ProductsDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return ProductsDb;
  }


  void createDb(Database db, int version) async {
    await db.execute(
        "Create table crProd(id integer primary key, masaNo integer, "
        "tavukSomun integer, etSomun integer, tavuk integer, et integer, "
        "etYogurt integer, tavukYogurt integer, ayran  integer, kola integer,"
        " su integer, salgam integer)");
    await db.execute("Create table products(id integer primary key,"
        "tavukSomun integer, etSomun integer, tavuk integer, et integer, "
        "etYogurt integer, tavukYogurt integer, ayran  integer, kola integer,"
        " su integer, salgam integer, tarih datetime)");
  }

  Future<List<Order>> getCrProd() async {
    Database db = await this.db;
    var result2 = await db.query("crProd");
    return List.generate(result2.length, (i) {
      return Order.fromObject(result2[i]);
    });
  }

  Future<List<Order>> getProducts() async {
    Database db = await this.db;
    var result1 = await db.query("products");
    return List.generate(result1.length, (i) {
      return Order.fromObject(result1[i]);
    });
  }

  Future<int> insertPr(Order order) async {
    Database db = await this.db;
    var result = await db.insert("products", order.toMap());
    return result;
  }

  Future<int> deletePr(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id= $id");
    return result;
  }

  Future<int> updatePr(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }

  Future<int> insertCr(List<currentProduct> crProd, int masaNo) async {
    var order = Order();
    Database db = await this.db;
    var result = await db.insert("crProd", order.formatChanger(crProd, masaNo));
    return result;
  }

  Future<int> deleteCr(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from crProd where id= $id");
    return result;
  }

  Future<int> updateCr(Product product) async {
    Database db = await this.db;
    var result = await db.update("crProd", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
