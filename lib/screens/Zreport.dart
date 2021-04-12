import 'package:flutter/material.dart';
import 'package:sqflite_demo/data/dbHelper.dart';

class OrderAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return OrderAddState();
  }

}

class OrderAddState extends State {
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "headline6",
//        theme: ThemeData.light().copyWith(
//          platform: _platform ?? Theme.of(context).platform,
//        ),
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
//                appBar: AppBar(
//                  title: Text(title),
//                ),
                body: SafeArea(
                    child: Column(children: <Widget>[
                      Container(
                        color: Colors.greenAccent,
                        width: MediaQuery.of(context).size.width / 2.2,  // Also Including Tab-bar height.
//                        child: Chewie(
//                          controller: _chewieController,
//                        ),
                      ),
                      PreferredSize(
                        preferredSize: Size.fromHeight(50.0),
                        child: TabBar(
                          labelColor: Colors.black,
                          tabs: [
                            Tab(
                              text: 'One',
                            ),
                            Tab(
                              text: 'Two',
                            ),
                            Tab(
                              text: 'Three',
                            )
                          ], // list of tabs
                        ),
                      ),
                      //TabBarView(children: [ImageList(),])
                      Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              color: Colors.deepOrange,
                              child: Center(child: Text('Tab1')),
                            ),
                            Container(
                              color: Colors.red,
                              child: Center(child: Text('Tab2')),
                            ),
                            Container(
                              color: Colors.yellowAccent,
                              child: Center(child: Text('Tab3')),
                            ) // class name
                          ],
                        ),
                      ),
                    ])))));
}