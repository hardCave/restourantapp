import 'package:flutter/foundation.dart';

import 'currentProducts.dart';

class Order {
  int id;
  int masaNo = 0;
  int tavukSomun = 0;
  int etSomun= 0;
  int tavuk= 0;
  int et= 0;
  int etYogurt= 0;
  int tavukYogurt= 0;
  int ayran= 0;
  int kola= 0;
  int su= 0;
  int salgam= 0;
  Order.currents(
      {this.id,
      this.masaNo,
      this.tavukSomun,
      this.etSomun,
      this.tavuk,
      this.et,
      this.etYogurt,
      this.tavukYogurt,
      this.ayran,
      this.kola,
      this.su,
      this.salgam});
  Order(
      {this.tavukSomun, this.etSomun, this.tavuk, this.et, this.etYogurt, this.tavukYogurt, this.ayran, this.kola, this.su, this.salgam});
  Order.withId(
      {this.id, this.tavukSomun, this.etSomun, this.tavuk, this.et, this.etYogurt, this.tavukYogurt, this.ayran, this.kola, this.su, this.salgam});
//z raporuna gidecek bilgiler
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["tavukSomun"] = tavukSomun;
    map["etSomun"] = etSomun;
    map["tavuk"] = tavuk;
    map["et"] = et;
    map["etYogurt"] = etYogurt;
    map["tavukYogurt"] = tavukYogurt;
    map["ayran"] = ayran;
    map["kola"] = kola;
    map["salgam"] = salgam;
    map["su"] = su;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

//z raporundan gelecek bilgiler.
  Order.fromObject(dynamic o) {
    this.id = o["id"];
    this.masaNo = o["masaNo"];
    this.tavukSomun = o["tavukSomun"];
    this.etSomun = o["etSomun"];
    this.tavuk = o["tavuk"];
    this.et = o["et"];
    this.etYogurt = o["etYogurt"];
    this.tavukYogurt = o["tavukYogurt"];
    this.ayran = o["ayran"];
    this.kola = o["kola"];
    this.su = o["su"];
    this.salgam = o["salgam"];
  }

  Map<String, dynamic> toMapCr() {
    var map = Map<String, dynamic>();
    map["masaNo"] = masaNo;
    map["tavukSomun"] = tavukSomun;
    map["etSomun"] = etSomun;
    map["tavuk"] = tavuk;
    map["et"] = et;
    map["etYogurt"] = etYogurt;
    map["tavukYogurt"] = tavukYogurt;
    map["ayran"] = ayran;
    map["kola"] = kola;
    map["salgam"] = salgam;
    map["su"] = su;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
  Map<String,Object> formatChanger(List<currentProduct> crProd,int masaNo){
    var map = Map<String, Object>();
    map["tavukSomun"] =0;
    map["etSomun"] =0;
    map["tavuk"] =0;
    map["et"] =0;
    map["etYogurt"] =0;
    map["tavukYogurt"] =0;
    map["ayran"] =0;
    map["kola"] =0;
    map["su"] =0;
    map["salgam"] =0;
    map["masaNo"] =0;
    for (int i = 0; i<crProd.length;i++ ) {
       if(crProd[i].product == "Tavuk Somun"){
        map["tavukSomun"] = crProd[i].adet;
      }
       if(crProd[i].product == "Et Somun"){
         map["etSomun"] = crProd[i].adet;
       }
       if(crProd[i].product == "Tavuk Lavaş"){
         map["tavuk"] = crProd[i].adet;
       }
       if(crProd[i].product == "Et Lavaş"){
         map["et"] = crProd[i].adet;
       }
       if(crProd[i].product == "Yoğurtlu Et"){
         map["etYogurt"] = crProd[i].adet;
       }
       if(crProd[i].product == "Yoğurtlu Tavuk"){
         map["tavukYogurt"] = crProd[i].adet;
       }
       if(crProd[i].product == "Ayran"){
         map["ayran"] = crProd[i].adet;
       }
       if(crProd[i].product == "Kola"){
         map["kola"] = crProd[i].adet;
       }
       if(crProd[i].product == "Su"){
         map["su"] = crProd[i].adet;
       }
       if(crProd[i].product == "Şalgam"){
         map["salgam"] = crProd[i].adet;
       }
       map["masaNo"] = masaNo;


    } print(map);return map;
  }

//z raporundan gelecek bilgiler.
  Order.fromObjectCr(dynamic o) {
    this.id = o["id"];
    this.masaNo = o["masaNo"];
    this.tavukSomun = o["tavukSomun"];
    this.etSomun = o["etSomun"];
    this.tavuk = o["tavuk"];
    this.et = o["et"];
    this.etYogurt = o["etYogurt"];
    this.tavukYogurt = o["tavukYogurt"];
    this.ayran = o["ayran"];
    this.kola = o["kola"];
    this.su = o["su"];
    this.salgam = o["salgam"];
  }
}
