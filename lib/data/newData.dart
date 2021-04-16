import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/orders.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper2 {
  Database _db;
// ONEMLİ
  // veritabanını tanımladık.. veritabanından sorguların gelmesi uzun sürebileceği için kullanıcı bu sırada işlem yaptığında
  // uygulamanın düzgün çalışması ve YANIT VERMİYOR  gibi hatalar vermemesi için database i asenkron çalıştırmalıyız
  //Asenkron çalışması demek veritabanı normal işlemlerimizin dışında gerçekleşecek demek
  // dolayısıyla aynı zamanda yazdığımız uygulamaya 5 saniye sonra mesela çalışcağını anlatmak için " FUTURE " diyerek bir söz veriyoruz...
  Future<Database> get db async {
    // uygulama ilk kez açıldığında veritabanı oluşturulmasını sağlar.
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

//database yi ileride vereceğim için yukarıda await dedim.. sana ileride cevap vericem demek await...
  Future<Database> initializeDb() async {
    //veritabanını oluşturacağım yere geldik
    //veritabanının yolunu göstermeliyim
    //data yolunu alıyorum ve join ile bunu programa anlatıyorum.. yine future işlem olduğu için await dedim
    String dbPath = join(await getDatabasesPath(), "Products.db");
    // database yolu hangisi ? dbpath tanımladık orası
    // oncreate nedir ? eğer database yoksa o zaman oluştur diyen kod
    var ProductsDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return ProductsDb;
  }

  void createDb(Database db, int version) async {
    //burada execute yani uygula diyerek oluşturduğum veritabanına bunları yap dedim..
    //ve içerisine yazdığım string ifade aslında sqflite dilinde kod.
    await db.execute(
        "Create table crProd(id integer primary key, masaNo integer, masaUrun integer,"
        "tavukSomun integer, etSomun integer, tavuk integer, et integer, "
        "etYogurt integer, tavukYogurt integer, ayran  integer, kola integer,"
        " su integer, salgam integer)");
    await db.execute("Create table products(id integer primary key,"
        "tavukSomun integer, etSomun integer, tavuk integer, et integer, "
        "etYogurt integer, tavukYogurt integer, ayran  integer, kola integer,"
        " su integer, salgam integer, tarih datetime)");
    // Her urun tektek // saatTarih bilgisi //
  }

  Future<List<Order>> getCrProd() async {
    Database db = await this.db;
    var result2 = await db.query("crProd");
    return List.generate(result2.length, (i) {
      return Order.fromObject(result2[i]);
    });
  }

  Future<List<Order>> getProducts() async {
    // ürünleri istemek için veritabanına eriştim.
    // yine veritabanına erişmek için sqflite a dedim ki bana "products" isimli tabloyu getir.
    Database db = await this.db;
    var result1 = await db.query("products");
    //productlari prodyct tipinde bir liste olarak geri döndürücem..
    // bunun için listeyi nasıl elde ederim? elime gelen bilgiler dynamic geldi ? dynamic gelen her bilgiyi tek tek
    //bir listeye eklerim.. generate ile bir for dongusu mantıgında i lenght kadar çalışıp her infoyu nesneye atıyor.
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

  Future<int> insertCr(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> deleteCr(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id= $id");
    return result;
  }

  Future<int> updateCr(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
