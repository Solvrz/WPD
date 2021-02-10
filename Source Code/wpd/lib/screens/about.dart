import 'package:flutter/material.dart';
import 'package:wpd_app/main.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 3 / 5,
            child: Image.asset("WPMBackIcon2.png")
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 32,16, 32),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey[850],
                  thickness: 1,
                  indent: 40,
                  endIndent: 40,
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 4, color: Colors.brown[200])
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "We at WPM aim at providing people with best water management. We believe in usage of Science & Technology for the betterment of the society. The company brought up its first prototype that is a Water Purity Detector. The company is managed by High School Students who are fond of making innovative ideas to tackle problems prevailing in our society. This software embeds with our prototype that tests the purity of water and also suggests that where the water can be used for or should be used for. And the output of the tests is display in this application.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ]
      )
    );
  }
}

