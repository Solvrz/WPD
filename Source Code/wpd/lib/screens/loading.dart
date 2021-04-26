import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wpd/main.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  int count = 0;

  late Animation animation;
  late Animation childAnimation;
  late AnimationController controller;

  SpinKitRing? loader;
  late Stopwatch _watch;

  void attemptConnect(timer) {
    InternetAddress.lookup('google.com').then((result) {
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Timer(
          const Duration(seconds: 5),
          () => Navigator.pushReplacementNamed(context, HomeRoute),
        );
      }
    }).catchError(
      (error) {
        if (count >= 7) {
          count = 0;
          timer.cancel();

          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Center(
                child: Text("No Internet connection!"),
              ),
              content: Text("Make sure you are connected to internet."),
              actions: [
                MaterialButton(
                  onPressed: () {
                    SystemNavigator.pop();
                    exit(0);
                  },
                  child: Text("Exit"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop('dialog');
                    InternetAddress.lookup('google.com').then((result) {
                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
                        Timer(const Duration(seconds: 3), () {
                          Navigator.pushReplacementNamed(context, HomeRoute);
                        });
                    }).catchError(
                      (_) {
                        Timer.periodic(
                          Duration(seconds: 1),
                          (timer) => attemptConnect(timer),
                        );
                      },
                    );
                  },
                  child: Text("Retry!"),
                )
              ],
            ),
          );
        } else
          count++;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    animation = Tween(begin: -1.4, end: -0.1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    childAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.ease),
      ),
    );

    controller.forward();

    Timer(Duration(milliseconds: 3500), () {
      setState(() {
        loader = SpinKitRing(
          color: Colors.blue[900]!,
          size: 40,
          lineWidth: 5,
          duration: Duration(milliseconds: 1500),
        );
      });
    });

    _watch = Stopwatch();
    _watch.start();

    InternetAddress.lookup('google.com').then((result) {
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Timer(const Duration(seconds: 10), () {
          Navigator.pushReplacementNamed(context, HomeRoute);
        });
      }
    }).catchError((error) {
      Timer.periodic(
        Duration(seconds: 1),
        (timer) => attemptConnect(timer),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AnimatedBuilder(
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return FadeTransition(
                  opacity: childAnimation as Animation<double>,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0,
                        animation.value * MediaQuery.of(context).size.height,
                        0.0),
                    child: SizedBox(
                      height: 120,
                      child: Image.asset("assets/images/WPMBrandLogo.png"),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 120,
            child: Center(child: loader),
          )
        ],
      ),
    );
  }
}
