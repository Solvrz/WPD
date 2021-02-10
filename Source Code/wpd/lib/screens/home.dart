import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wpd_app/main.dart';
import 'dart:io';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Center(child: Text("Quitting"),),
            content: Text("Are you sure you want to quit the app?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  SystemNavigator.pop();
                  exit(0);
                },
                child: Text("Yes")
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("No"),
              )
            ],
          )
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("WPM SURE"),
          centerTitle: true,
          elevation: 2,
        ),
        body: Stack(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3 / 5,
              child: Image.asset("WPMBackIcon2.png")
            ),
            Container(
              padding: EdgeInsets.fromLTRB(18, 18, 18, 0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      "Welcome to the Home Page!",
                      style: TextStyle(
                        color: Colors.grey[850],
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),
                  Divider(
                    height: 40,
                    thickness: 1,
                    color: Colors.grey[900]
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, HistoryRoute);
                            },
                            child: SizedBox(
                              height: 50,
                              width: 62.5,
                              child: Center(
                                child: Text(
                                  "Results",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            color: Colors.deepOrange[500],

                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AboutRoute);
                            },
                            child: SizedBox(
                              height: 50,
                              width: 70,
                              child: Center(
                                child: Text(
                                  "About Us",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            color: Colors.deepOrange[500],
                          )
                        ],
                      )
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 4/2,
                    child: SizedBox(
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "HANDCRAFTED BY MEHRRAJ, ADITYA, LOVISH",
                              style: TextStyle(
                                fontFamily: "VT323",
                                fontSize: 20
                              ),
                            ),
                          ),
                          SizedBox(height: 2.5),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "TAILORED BY R.P. SINGH",
                              style: TextStyle(
                                  fontFamily: "VT323",
                                  fontSize: 20
                              ),
                            ),
                          ),
                          SizedBox(height: 2.5),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "STITCHED @ OPBMS, PUNJAB",
                              style: TextStyle(
                                  fontFamily: "VT323",
                                  fontSize: 20
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  )
                ],
              )
            ),
          ]
        ),
      ),
    );
  }
}

