class Order {
  int id;
  int tavukSomun;
  int etSomun;
  int tavuk;
  int et;
  int etYogurt;
  int tavukYogurt;
  int ayran;
  int kola;
  int su;
  int salgam;
  DateTime saat;

  Order({this.tavukSomun,this.etSomun,this.tavuk,this.et,this.etYogurt,this.tavukYogurt,this.ayran,this.kola,this.su,this.salgam,this.saat});
  Order.withId({this.id,this.tavukSomun,this.etSomun,this.tavuk,this.et,this.etYogurt,this.tavukYogurt,this.ayran,this.kola,this.su,this.salgam,this.saat});
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
    map["su"] = salgam;
    map["saat"] = saat;
    map["su"] = su;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
//z raporuna gelecek bilgiler.
  Order.fromObject(dynamic o) {
    this.id = o["id"];
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
    this.saat = o["saat"];
  }
}
