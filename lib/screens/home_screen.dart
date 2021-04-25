import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          GridView.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 2,
            primary: false,
            children: <Widget>[
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
                      ),
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
                  ))
            ],
          )
        ],
      ),
    );
  }
}
