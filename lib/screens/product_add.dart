
import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';
import 'package:sqflite_demo/models/product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return ProductAddState();
  }

}

class ProductAddState extends State{
  var dbHelper = DbHelper();
  //textleri kontrol ettiğimiz classtır
  TextEditingController txtName =new TextEditingController();
  TextEditingController txtDescription =new TextEditingController();
  TextEditingController txtUnitPrice =new TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni ürün ekle"),
      ),
      body: Padding(
        //padding kenarlardan boşluk bırakmamıza yarıyor istersek sağdan soldan ayrı ayrı bırabiliriz
        padding: EdgeInsets.all(30.0),
        child: Column(
          //childeren ile alt alta widget koyabildiğimiz bir kolon türü
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Adı",),
      controller: txtName,
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması",),
      controller: txtDescription,
    );
  }

  TextField buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ürün Fiyatı",),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return FlatButton(
        child: Text("Ekle"),
        onPressed: (){
          addProduct();
          },
      );
    }

  void addProduct() async {
    //product yapıcı metodundaki tanım gereği burada isimlendirmeyi bu şekilde yapmak gerekiyormuş
    var result = await dbHelper.insert(Product(name : txtName.text, description: txtDescription.text, unitPrice: double.tryParse(txtUnitPrice.text)));
    //işlemin başarılı olduğunu döndürüyorum...
    Navigator.pop(context,true);

  }
}