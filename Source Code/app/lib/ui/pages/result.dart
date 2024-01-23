import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final QueryDocumentSnapshot doc;

  const ResultPage(this.doc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${doc['date']}  ${doc['time']}",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            AspectRatio(
              aspectRatio: 7 / 5,
              child: Container(
                margin: const EdgeInsets.only(top: 8, bottom: 16),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.cyan[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minHeight: 150,
                  minWidth: 200,
                  maxHeight: 300,
                  maxWidth: 400,
                ),
                child: Center(
                  child: Text(
                    doc["description"],
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 30),
            Wrap(
              spacing: 10,
              runSpacing: 16,
              children: [
                _ResultBox(
                  doc,
                  "pH",
                  "assets/images/PH.png",
                  const Color(0xffbbd14e),
                ),
                _ResultBox(
                  doc,
                  "Temprature",
                  "assets/images/TEMPRATURE.png",
                  const Color(0xffc2839d),
                ),
                _ResultBox(
                  doc,
                  "Conductivity",
                  "assets/images/CONDUCTIVITY.png",
                  const Color(0xff4ba54f),
                ),
                _ResultBox(
                  doc,
                  "PPM",
                  "assets/images/PPM.png",
                  const Color(0xff67b8ff),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResultBox extends StatelessWidget {
  final QueryDocumentSnapshot doc;
  final String label;
  final String logo;
  final Color? color;

  const _ResultBox(
    this.doc,
    this.label,
    this.logo,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints.expand(
        width: 150,
        height: 100,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                constraints: const BoxConstraints.expand(height: 20, width: 20),
                child: Image.asset(logo),
              ),
              const SizedBox(width: 5),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                doc[label.toLowerCase()] ?? "Loading",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
