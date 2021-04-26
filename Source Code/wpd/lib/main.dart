import 'package:flutter/material.dart';
import 'package:wpd/screens/about.dart';
import 'package:wpd/screens/history.dart';
import 'package:wpd/screens/home.dart';
import 'package:wpd/screens/loading.dart';
import 'package:wpd/screens/result.dart';

void main() => runApp(App());

const HomeRoute = "/home";
const ResultRoute = "/result";
const HistoryRoute = "/history";
const AboutRoute = "/about";

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
      home: LoadingPage(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      Map<String, dynamic>? arguments =
          settings.arguments as Map<String, dynamic>?;
      Widget screen;

      switch (settings.name) {
        case HomeRoute:
          screen = HomePage();
          break;

        case ResultRoute:
          screen = ResultPage(arguments!["doc"]);
          break;

        case HistoryRoute:
          screen = HistoryPage();
          break;

        case AboutRoute:
          screen = AboutPage();
          break;

        default:
          return null;
      }

      return MaterialPageRoute(builder: (context) => screen);
    };
  }
}
