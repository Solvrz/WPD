import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireApp extends StatelessWidget {
  List<Widget>? createbandWidgets(snapshot) {
    return snapshot.data.documents.map<Widget>((doc) {
      return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
        constraints: BoxConstraints.expand(
          width: 100,
          height: 100,
        ),
        decoration: BoxDecoration(color: Colors.amberAccent),
        child: Center(
          child: Text(doc["name"]),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("WPD"),
          centerTitle: true,
          backgroundColor: Colors.deepOrange,
          elevation: 2.0,
        ),
        body: Container(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("bandnames").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Text("Loading..."),
                );

              return Wrap(
                children: createbandWidgets(snapshot)!,
              );
            },
          ),
        ),
      ),
    );
  }
}
