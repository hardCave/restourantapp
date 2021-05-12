import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/months.dart';
import 'package:sqflite_demo/models/productModel.dart';
import 'package:sqflite_demo/models/reportModel.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DatabaseHelper dbhelper = DatabaseHelper();
  var date = DateTime.now();

  _ReportScreenState() {}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gün Sonu Ayları"),
      ),
      body: rListBuilder(),
    );
  }

  monthList(int Deger) {
    Map map = Map();
    map[1] = "Ocak";
    map[2] = "Şubat";
    map[3] = "Mart";
    map[4] = "Nisan";
    map[5] = "Mayıs";
    map[6] = "Haziran";
    map[7] = "Temmuz";
    map[8] = "Ağustos";
    map[9] = "Eylül";
    map[10] = "Ekim";
    map[11] = "Kasım";
    map[12] = "Aralık";

    return map[Deger];
  }

  rListBuilder() {
    return Column(
      children: [
        Flexible(
          flex: 10,
          child: Column(
            children: [
              FutureBuilder<List<Month>>(
                  future: dbhelper.getMonthList(),
                  builder: (context, AsyncSnapshot<List<Month>> snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("hatajhkjhkjhkj"),
                      );
                    } else if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int position) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.cyan,
                                elevation: 2.4,
                                child: ListTile(
                                  title: Text(
                                      monthList(snapshot.data[position].month) +
                                          " " +
                                          snapshot.data[position].year
                                              .toString()),
                                  onTap: () {
                                    setState(() {
                                      //2. report screene navigeytle beyb
                                    });
                                  },
                                ),
                              );
                            }),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Text("else girdi");
                    }
                  }),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    endDayReport();
                  });
                },
                child: Text("Gün Sonu Al"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void endDayReport() async {
    var daily = await dbhelper.getDailyList();
    var crProd = await dbhelper.getProdList();
    var repZ = ReportZ();
    var mon = Month();
    mon.month = date.month;
    mon.year = date.year;
    mon.id = null;
    dbhelper.insertM(mon);

    repZ.dateYear = date.year;
    repZ.dateMonth = date.month;
    repZ.dateDay = date.day;
    repZ.id = null;
    String abc = "";
    String prn = "";
    for (int i = 0; i < daily.length; i++) {
      for (int j = 0; j < crProd.length; j++) {
        if (crProd[j].productId == daily[i].productId) {
          prn = crProd[j].productName;
        }
      }
      abc += daily[i].productsCount.toString() + "Ad. " + prn + "\n";
    }
    repZ.productsId = abc;
    var result = dbhelper.insertZ(repZ);
  }
}
