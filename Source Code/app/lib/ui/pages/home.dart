import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'result.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WPD"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
              color: Colors.grey[900],
            ),
            const SizedBox(height: 25),
            FittedBox(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[850]!),
                  borderRadius: BorderRadius.circular(5),
                ),
                constraints:
                    const BoxConstraints.expand(height: 400, width: 350),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("results")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text("Loading..."),
                      );
                    }

                    return ListView(
                      children: snapshot.data!.docs
                          .map<Widget>((doc) {
                            return _ResultCard(doc);
                          })
                          .toList()
                          .reversed
                          .toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const _ResultCard(this.doc);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ResultPage(doc)),
        ),
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
                          fontWeight: FontWeight.bold,
                        ),
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
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: " ${doc['ph']}",
                                style: TextStyle(
                                  color: Colors.cyan[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    doc["time"],
                    style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
