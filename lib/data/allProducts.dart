class AllProducts{

  double tavukSomun = 12;
  double etSomun = 14;
  double tavuk = 11;
  double et = 13;
  double etYogurt = 17;
  double tavukYogurt = 15;
  double ayran = 3;
  double kola = 5;
  double su = 2;
  double salgam = 3;
  AllProducts({this.tavukSomun,this.etSomun,this.tavuk,this.et,this.etYogurt,this.tavukYogurt,this.ayran,this.kola,this.su,this.salgam});
  Map<String, double> getDefaultProducts() {
    var map = Map<String, double>();
    map["Tavuk Somun"] = tavukSomun;
    map["Et Somun"] = etSomun;
    map["Tavuk Lavaş"] = tavuk;
    map["Et Lavaş"] = et;
    map["Yoğurtlu Et"] = etYogurt;
    map["Yoğurtlu Tavuk"] = tavukYogurt;
    map["Ayran"] = ayran;
    map["Kola"] = kola;
    map["Su"] = su;
    map["Şalgam"] = salgam;
    return map;
  }
}