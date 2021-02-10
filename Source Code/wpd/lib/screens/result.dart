import 'package:flutter/material.dart';
import 'package:wpd_app/main.dart';

class ResultPage extends StatelessWidget {
  final doc;

  ResultPage(this.doc);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            // Date & Time from the doc
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${doc['date']}  ${doc['time']}",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SizedBox(height: 50, child: Image.asset("WPMBrandLogo.png"))
                  ),
                )
              ]
            ),
            // Description from the doc
            AspectRatio(
              aspectRatio: 7 / 5,
              child: Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.cyan[400],
                  borderRadius: BorderRadius.circular(10)
                ),
                constraints: BoxConstraints(
                  minHeight: 150,
                  minWidth: 200,
                  maxHeight: 300,
                  maxWidth: 400
                ),
                child: Center(child: Text(
                  doc["description"],
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ))
              ),
            ),
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.grey[600],
            ),
            SizedBox(height: 30),
            // Wrap around the result boxes using the doc
            Wrap(
              spacing: 10,
              runSpacing: 16,
              children: <Widget>[
                ResultBox(doc, "pH", "logo1.png", Colors.amberAccent[200]),
                ResultBox(doc, "Temp", "logo2.png", Colors.deepOrange[400]),
                ResultBox(doc, "Cond", "logo4.png", Colors.lightBlue[200]),
                ResultBox(doc, "ppm", "logo3.png", Colors.lightGreen[300]),
              ],
            )
          ],
        ),
      )
    );
  }
}

class ResultBox extends StatelessWidget {
  final doc;
  final label;
  final logoPath;
  final color;

  ResultBox(this.doc, this.label, this.logoPath, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      constraints: BoxConstraints.expand(
        width: SizeConfig.blockSizeHorizontal * 40, //140,
        height: SizeConfig.blockSizeVertical * 15 //100
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  constraints: BoxConstraints.expand(
                    height: 20,
                    width: 20
                  ),
                  child: Image.asset(logoPath)
                )
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  )
                )
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
            child: Center(child: Text(
              () {
                var data = doc[label];
                if (data != null) {
                  return data;
                } else {
                  return "Loading";
                }
              }(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),),
          )
        ],
      ),
    );
  }
}

