import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite_demo/screens/Masalar.dart';
import 'package:sqflite_demo/screens/product_list.dart';

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
            height: size.height * .3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/images/top_header.png'))),
          ),
          returnGrid(cardTextStyle),
        ],
      ),
    );
  }

  returnGrid(cardTextStyle) {
    return GridView.count(
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      primary: false,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ProductList.withoutInfo()),
                (Route<dynamic> route) => true);
          },
          child: Card(
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
                  ),
                ],
              )),
        ),
        GestureDetector(
          onTap: () {
            //Navigator.of(context).pushAndRemoveUntil(
            //MaterialPageRoute(builder: (context) => ((Masalar)),
            //(Route<dynamic> route) => true);
//burası ürün ekleme sayfasına yönlendirecek
          },
          child: Card(
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
                    Icons.add_shopping_cart,
                    color: Colors.deepOrange,
                    size: 90.0,
                  ),
                  Text(
                    'ÜRÜN EKLEME',
                    style: cardTextStyle,
                  )
                ],
              )),
        ),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(31)),
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
                  Icons.add_alert,
                  color: Colors.deepOrange,
                  size: 90.0,
                ),
                Text(
                  'GÜN SONU',
                  style: cardTextStyle,
                )
              ],
            )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(31)),
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
                  'AKTİF SİPARİŞLER',
                  style: cardTextStyle,
                )
              ],
            )),
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
    );
  }
}
