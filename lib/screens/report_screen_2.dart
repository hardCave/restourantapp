import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/reportModel.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class RScreen2 extends StatefulWidget {
  int month;
  int year;

  RScreen2(month, year) {
    this.month = month;
    this.year = year;
  }

  @override
  _RScreen2State createState() => _RScreen2State(month, year);
}

class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;

  ItemModel(
      {this.expanded: false,
      this.headerItem,
      this.discription,
      this.colorsItem});
}

class _RScreen2State extends State<RScreen2> {
  DatabaseHelper dbhelper = DatabaseHelper();
  var date = DateTime.now();
  int month;
  int year;
  var theListRepZ = List<ReportZ>();
  var itemData = List<ItemModel>();

  _RScreen2State(month, year) {
    this.month = month;
    this.year = year;
  }

  @override
  void initState() {
    fetchYap();
    super.initState();
  }

  Future<void> fetchYap() async {
    var temp = await getReportZList();
    setState(() {
      theListRepZ = temp;
    });
  }

  Future<List<ReportZ>> getReportZList() async {
    var urunList = await dbhelper.getReportByMonthList(month, year);
    var urunler = urunList;
    if (urunler != null) {
      return urunler;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gün Sonu"),
      ),
      body: pageBuilder(),
    );
  }

  var obj = ItemModel();
  itemModelBack() {
    var list = List<ItemModel>();

    for (int i = 0; i < theListRepZ.length; i++) {
      obj.headerItem = theListRepZ[i].dateDay.toString() + ". Gün";
      obj.discription = theListRepZ[i].productsId;
      obj.colorsItem = Colors.green;
      list.add(obj);
    }
    return list;
  }

  pageBuilder() {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blueGrey.shade400,
      child:
      FutureBuilder<List<ReportZ>>(
          future: dbhelper.getReportByMonthList(month, year),
          builder: (context, AsyncSnapshot<List<ReportZ>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("hatajhkjhkjhkj"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.deepPurple.shade200,
                        child: ListTile(
                          title: Text(snapshot.data[index].dateDay.toString() + " .Gün"),
                          subtitle: Text(snapshot.data[index].productsId),
                        ),
                      );
                    },
                  );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Text("else girdi");
            }
          })
    );
  }
}
