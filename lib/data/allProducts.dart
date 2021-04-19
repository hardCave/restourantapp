class AllProducts{
  double tavukSomun = 12.0;
  double etSomun = 14;
  double tavuk = 11;
  double et = 13;
  double etYogurt = 17;
  double tavukYogurt = 15;
  double ayran = 3;
  double kola = 5;
  double su = 2;
  double salgam = 3;

  Map<String, double> getDefaultProducts() {
    var map = Map<String,double>();
    map["Tavuk Somun"] =12;
    map["Et Somun"] = 15;
    map["Tavuk Lavaş"] = 13;
    map["Et Lavaş"] = 14;
    map["Yoğurtlu Et"] = 16;
    map["Yoğurtlu Tavuk"] = 15;
    map["Ayran"] = 3;
    map["Kola"] = 5;
    map["Su"] = 2;
    map["Şalgam"] = 3;
    return map;
  }
  AllProducts({this.tavukSomun,this.etSomun,this.tavuk,this.et,this.etYogurt,this.tavukYogurt,this.ayran,this.kola,this.su,this.salgam});
}