import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wpd/main.dart';

class HistoryPage extends StatelessWidget {
  List<Widget>? createResults(snapshot) {
    return snapshot.data.documents
        .map<Widget>((doc) {
          return ResultCard(doc);
        })
        .toList()
        .reversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Image.asset("assets/images/WPMBrandLogo.png"),
            ),
            SizedBox(height: 25),
            Center(
              child: Text(
                "The results of last 5 tests will be displayed here.",
                style: TextStyle(color: Colors.grey[850], fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
                height: 30,
                thickness: 1,
                indent: 50,
                endIndent: 50,
                color: Colors.grey[900]),
            SizedBox(height: 25),
            FittedBox(
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[850]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                constraints: BoxConstraints.expand(height: 400, width: 350),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("history")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(
                        child: Text("Loading..."),
                      );

                    return ListView(
                      children: createResults(snapshot)!,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final doc;

  ResultCard(this.doc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
        color: Colors.amberAccent,
        onPressed: () =>
            Navigator.pushNamed(context, ResultRoute, arguments: {"doc": doc}),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        doc["date"],
                        style: TextStyle(
                            color: Colors.grey[850],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: TextSpan(
                              text: "pH:",
                              style: TextStyle(
                                  color: Colors.grey[850],
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: " ${doc['pH']}",
                                  style: TextStyle(
                                      color: Colors.cyan[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    doc["time"],
                    style: TextStyle(
                        color: Colors.grey[850],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
