import 'package:flutter/material.dart';
import 'package:sqflite_demo/utis/dbHelper.dart';

/*class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}*/

class UpdateScreenSecond extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _UpdateScreenSecondState();
  }
}

titleReturn(String text, x, String font, double fontsize) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: font,
        fontSize: fontsize,
        color: x,
      ),
    ),
  );
}

class _UpdateScreenSecondState extends State {
  DatabaseHelper dbhelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title:
            titleReturn("Ürün Ekle ve Güncelle", Colors.white, "Raleway", 24),
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: uListBuilder(),
    );
  }

  uListBuilder() {
    return Column(
      children: [
        Flexible(
          flex: 10,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade400.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                //color: Colors.purple,
                child: TextField(
                  style: TextStyle(
                      fontFamily: "Raleway", fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' Ürün Adı',
                      hintStyle: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 24,
                          color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
        Flexible(
          flex: 10,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade400.withOpacity(0.8),
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Center(
                //color: Colors.purple,
                child: TextField(
                  style: TextStyle(
                      fontFamily: "Raleway", fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' Ürün Fiyatı',
                      hintStyle: TextStyle(
                          fontFamily: "Raleway",
                          fontSize: 24,
                          color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          splashColor: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(52),
          child: Container(
            child: Card(
              color: Colors.deepPurple.shade300,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              child: SizedBox(
                  height: 50,
                  width: 230,
                  child: titleReturn("Yeni Ürün", Colors.white, "Raleway", 24)),
            ),
          ),
        ),
      ],
    );
  }
}

createAlertDialog(BuildContext context) {
  TextEditingController customController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(31.0)),
            title: Text("Ürün Güncelleme",
                style: TextStyle(
                    color: Colors.deepPurple.shade500,
                    fontFamily: "Raleway",
                    fontSize: 24)),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Sil',
                    style: TextStyle(
                        color: Colors.deepPurple.shade500,
                        fontFamily: "Raleway",
                        fontSize: 20)),
                onPressed: () {},
              ),
              MaterialButton(
                elevation: 5.0,
                child: Text('Güncelle',
                    style: TextStyle(
                        color: Colors.deepPurple.shade500,
                        fontFamily: "Raleway",
                        fontSize: 20)),
                onPressed: () {},
              )
            ]);
      });
}
