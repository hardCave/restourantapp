import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_demo/screens/Masalar.dart';
import 'package:sqflite_demo/screens/product_list.dart';
import 'package:sqflite_demo/screens/report_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _controller.forward();
    _controller.addListener(() {
      print(_controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardTextStyle = TextStyle(
        fontFamily: "Raleway",
        fontSize: 14,
        color: Color.fromRGBO(63, 63, 63, 1));
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: size.height * .3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/top_header.png'))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 95.0),
            child: Container(
              alignment: Alignment.center,
              height: 500,
              width: 1080,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      scale: 4,
                      alignment: Alignment.topCenter,
                      image: AssetImage('assets/images/selim_tantuni.png'))),
            ),
          ),
          returnGrid(cardTextStyle),
        ],
      ),
    );
  }

  returnGrid(cardTextStyle) {
    return Padding(
      padding: const EdgeInsets.only(top: 270.0),
      child: GridView.count(
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        crossAxisCount: 2,
        primary: false,
        children: <Widget>[
          //SİPARİŞ AL
          InkWell(
            splashColor: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(52),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Masalar()),
                  (Route<dynamic> route) => true);
            },
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52)),
                elevation: 10,
                margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                child: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 13,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(
                          bottom: 8.5,
                          top: 8.5,
                          right: 8.5,
                          left: 8.5,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/take_order.png'))),
                        child: Text(' '),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: SizedBox(
                        child: Text(
                          'SİPARİŞ AL',
                          style: cardTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //AKTİF MASALAR
          InkWell(
            splashColor: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(52),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => ProductList.withoutInfo()),
                  (Route<dynamic> route) => true);
            },
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52)),
                elevation: 10,
                margin: const EdgeInsets.only(bottom: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 13,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(
                          bottom: 6,
                          top: 6,
                          right: 6,
                          left: 6,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/active_orders.png'))),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: SizedBox(
                        child: Text(
                          'AKTİF MASALAR',
                          style: cardTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //GÜN SONU
          InkWell(
            splashColor: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(52),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ReportScreen()),
                  (Route<dynamic> route) => true);
            },
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52)),
                elevation: 10,
                margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
                child: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 13,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(
                          bottom: 9,
                          top: 9,
                          right: 9,
                          left: 9,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/cash_flow.png'))),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: SizedBox(
                        child: Text(
                          'GÜN SONU',
                          style: cardTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //ÜRÜN EKLE
          InkWell(
            splashColor: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(52),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Masalar()),
                  (Route<dynamic> route) => true);
            },
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(52)),
                elevation: 10,
                margin: const EdgeInsets.only(bottom: 20.0, right: 20.0),
                child: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 13,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(
                          bottom: 8.5,
                          top: 8.5,
                          right: 8.5,
                          left: 8.5,
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/add_product.png'))),
                        child: Text(' '),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 3,
                      child: SizedBox(
                        child: Text(
                          'ÜRÜN EKLE',
                          style: cardTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //KARTLARIN ESKİ HALİ
          /* Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(31)),
                    elevation: 4,
                    margin: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 15.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_moderator,
                          color: Colors.deepOrange,
                          size: 90.0,
                        ),
                        Text(
                          'SİPARİŞ AL ',
                          style: cardTextStyle,
                        )
                      ],
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(31)),
                    elevation: 4,
                    margin: const EdgeInsets.only(
                      left: 15.0,
                      right: 15.0,
                      top: 15.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add_moderator,
                          color: Colors.deepOrange,
                          size: 90.0,
                        ),
                        Text(
                          'SİPARİŞ AL ',
                          style: cardTextStyle,
                        )
                      ],
                    ))*/
        ],
      ),
    );
  }
}
