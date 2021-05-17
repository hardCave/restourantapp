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
    itemData = list;
  }

  pageBuilder() {
    itemModelBack();
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: itemData.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionPanelList(
            animationDuration: Duration(milliseconds: 1000),
            dividerColor: Colors.red,
            elevation: 1,
            children: [
              ExpansionPanel(
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "" + itemData[index].discription.toString(),
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                            letterSpacing: 0.3,
                            height: 1.3),
                      ),
                    ],
                  ),
                ),
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      itemData[index].headerItem,
                      style: TextStyle(
                        color: itemData[index].colorsItem,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                isExpanded: itemData[index].expanded,
              )
            ],
            expansionCallback: (int item, bool status) {
              setState(() {
                itemData[index].expanded = !itemData[index].expanded;
              });
            },
          );
        },
      ),
    );
  }
}
