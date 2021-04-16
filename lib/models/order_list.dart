
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/newData.dart';
import 'package:sqflite_demo/models/orders.dart';

class OrderList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderListState();
  }
}

class _OrderListState extends State {
  var dbHelper = DbHelper2();
  List<Order> orders;

  int orderCount = 0;

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
      appBar: AppBar(title: Text("Aktif Siparişler")),
      body: buildProductList(),
      //ürün ekleme butonu floating
      floatingActionButton: FloatingActionButton(
        //basıldığında ne olacak
        //fonksiyonu çalıştıracak
        onPressed: () {
          goOrderAdd();
        },
        //butonun ikonu ne olacak
        child: Icon(Icons.add),
        //kullanıcıya hint
        tooltip: "Yeni Sipariş Ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: 50,
        //itembuilder elemanları tek tek dolaşan bir for döngüsü gibi çalışiyor
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.4,
            // elevation büyüklük verir
            child: ListTile(
              //title:, // masa numarası,
              //subtitle:, // masa ürünleri listesi,
              // onTap: () {},
            ),
          );
        });
  }

  void goToProductAdd() async {
    bool result = false;
    Navigator.pushNamed(context, "/masalarpage");
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    //initState bu fonksiyonun içindeki nesne değişken herhangi bişey, ileride değeri değiştiğinde mesela
    //veritabanından veri gelidğinde, bu nesneleri kullanan bütün widgetları tekrar çalıştırı günceller yeniden build gerçekleşir
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      this.orders = data;
      orderCount = data.length;
    });
  }

  Text currentOrders() {

  }

  void goOrderAdd() {

    // bool result =  Navigator.pushNamed(context, "/orderaddpage");
    // if (result != null) {
      //if (result) {
        // getProducts();
      }
    }

