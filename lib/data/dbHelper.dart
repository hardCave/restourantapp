import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper{
  Database _db;
// ONEMLİ
  // veritabanını tanımladık.. veritabanından sorguların gelmesi uzun sürebileceği için kullanıcı bu sırada işlem yaptığında
  // uygulamanın düzgün çalışması ve YANIT VERMİYOR  gibi hatalar vermemesi için database i asenkron çalıştırmalıyız
  //Asenkron çalışması demek veritabanı normal işlemlerimizin dışında gerçekleşecek demek
  // dolayısıyla aynı zamanda yazdığımız uygulamaya 5 saniye sonra mesela çalışcağını anlatmak için " FUTURE " diyerek bir söz veriyoruz...
  Future<Database> get db async{
    // uygulama ilk kez açıldığında veritabanı oluşturulmasını sağlar.
    if (_db == null){
      _db = await initializeDb();
    }
    return _db;
  }
//database yi ileride vereceğim için yukarıda await dedim.. sana ileride cevap vericem demek await...
  Future<Database> initializeDb() async{
    //veritabanını oluşturacağım yere geldik
    //veritabanının yolunu göstermeliyim
    //data yolunu alıyorum ve join ile bunu programa anlatıyorum.. yine future işlem olduğu için await dedim
    String dbPath =join(await getDatabasesPath(),"etrade.db");
    // database yolu hangisi ? dbpath tanımladık orası
    // oncreate nedir ? eğer database yoksa o zaman oluştur diyen kod
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    //burada execute yani uygula diyerek oluşturduğum veritabanına bunları yap dedim..
    //ve içerisine yazdığım string ifade aslında sqflite dilinde kod.
    await db.execute("Create table products(id integer primary key, name text, description text, unitPrice integer)");
  }

  Future<List<Product>> getProducts() async {
    // ürünleri istemek için veritabanına eriştim.
    // yine veritabanına erişmek için sqflite a dedim ki bana "products" isimli tabloyu getir.
    Database db =await this.db;
    var result = await db.query("products");
    //productlari prodyct tipinde bir liste olarak geri döndürücem..
    // bunun için listeyi nasıl elde ederim? elime gelen bilgiler dynamic geldi ? dynamic gelen her bilgiyi tek tek
    //bir listeye eklerim.. generate ile bir for dongusu mantıgında i lenght kadar çalışıp her infoyu nesneye atıyor.
    return List.generate(result.length, (i) {
      return Product.fromObject(result[i]);
    });
  }
  Future<int> insert(Product product) async {
    Database db =await this.db;
    var result = await db.insert("products",product.toMap());
  }
  Future<int> delete(int id) async {
    Database db =await this.db;
    var result = await db.rawDelete("delete from products where id= $id");
    return result;
  }
  Future<int> update(Product product) async {
    Database db =await this.db;
    var result = await db.update("products", product.toMap(), where: "id=?",whereArgs: [product.id]);
    return result;
  }
}