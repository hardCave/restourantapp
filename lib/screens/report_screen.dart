import 'package:flutter/material.dart';
import 'package:sqflite_demo/models/months.dart';
import 'package:sqflite_demo/models/reportModel.dart';
import 'package:sqflite_demo/screens/report_screen_2.dart';
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
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => RScreen2(
                                                  snapshot.data[position].month,
                                                  snapshot
                                                      .data[position].year)),
                                          (Route<dynamic> route) => true);
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
    var repZ = ReportZ();
    var mon = Month();
    var daily = await dbhelper.getDailyList();
    var crProd = await dbhelper.getProdList();
    var monL = await dbhelper.getMonthList();
    var repList = await dbhelper.getReportByDayList(date.month, date.year, date.day);
    if (monL.isEmpty ||(monL.any((e) => e.year == date.year && e.month == date.month))) {
      mon.month = date.month;
      mon.year = date.year;
      mon.id = null;
      dbhelper.insertM(mon);
      monL = await dbhelper.getMonthList();
    }

    /*for (int i = 0; i < monL.length; i++) {

      if (monL[i].month != date.month && monL[i].year != date.year) {

        print("145 çalıştı ... reportscreen");
        mon.month = date.month;
        mon.year = date.year;
        mon.id = null;
        dbhelper.insertM(mon);
        repZ.id = null;
        repZ.dateYear = date.year;
        repZ.dateMonth = date.month;
        repZ.dateDay = date.day;
        repZ.productsId = "";
      } else {

        var repZZ =
        await dbhelper.getReportByDayList(date.month, date.year, date.day);
        repZ.id = repZZ[0].id;

        if (repZ.productsId == null) {

          repZ.productsId = "";

        }
        repZ.productsId += repZZ[0].productsId;
        repZ.dateDay = repZZ[0].dateDay;
        repZ.dateMonth = repZZ[0].dateMonth;
        repZ.dateYear = repZZ[0].dateYear;
        stat = true;

      }
    }*/


    /*if(repList.isNotEmpty){
      repList[0].productsId = "";
      dbhelper.updateZ(repList[0]);
    }*/


    repZ.id = null;
    repZ.dateMonth = date.month;
    repZ.dateYear = date.year;
    repZ.dateDay = date.day;
    repZ.productsId = "";
    print(daily.length.toString() + " daily leng");
    print(crProd.length.toString() + " mevcut ürünler lenght");
    for (int i = 0; i < daily.length; i++) {
      for (int j = 0; j < crProd.length; j++) {
        if (crProd[j].productId == daily[i].productId) {
          repZ.productsId += daily[i].productsCount.toString() +
              " Adet. " +
              crProd[j].productName +
              "   Toplam ${crProd[j].productPrice * daily[i].productsCount} ₺" +
              "\n";
        }
      }
    }
    dbhelper.deleteZbyDay(date.year, date.month, date.day);
      dbhelper.insertZ(repZ);

  }
}
