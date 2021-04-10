import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';
import 'package:sqflite_demo/screens/product_add.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper =  DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  //
  void initState() {
    //initState bu fonksiyonun içindeki nesne değişken herhangi bişey, ileride değeri değiştiğinde mesela
    //veritabanından veri gelidğinde, bu nesneleri kullanan bütün widgetları tekrar çalıştırı günceller yeniden build gerçekleşir
   getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Ürün Listesi")
        ),
      body: buildProductList(),
      //ürün ekleme butonu floating
      floatingActionButton: FloatingActionButton(
        //basıldığında ne olacak
        //fonksiyonu çalıştıracak
        onPressed: (){goToProductAdd();},
        //butonun ikonu ne olacak
        child: Icon(Icons.add),
        //kullanıcıya hint
        tooltip: "Yeni Ürün Ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount : productCount,
        //itembuilder elemanları tek tek dolaşan bir for döngüsü gibi çalışiyor
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.cyan,
            elevation: 2.4,
            // elevation büyüklük verir
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.black26, child: Text("MN"),),
              title: Text(this.products[position].name,),
              subtitle: Text(this.products[position].description,),
              onTap: (){

              },
            ),
          );
        }
    );
  }

  void goToProductAdd() async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductAdd()));
    if(result != null ){
      if(result){
        getProducts();
      }
    }
  }

  void getProducts () async{
    //initState bu fonksiyonun içindeki nesne değişken herhangi bişey, ileride değeri değiştiğinde mesela
    //veritabanından veri gelidğinde, bu nesneleri kullanan bütün widgetları tekrar çalıştırı günceller yeniden build gerçekleşir
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data){
      this.products = data;
      productCount = data.length;
    });
  }
}
