import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gün Sonu Ayları"),
      ),
      body: rListBuilder(),
    );
  }

  rListBuilder() {
    return Column(
      children: [
        Flexible(),
        Flexible(
          child: Column(
            children: [
              Row(),
              Row()
            ],
          ),
        ),
      ],
    );
  }
}
