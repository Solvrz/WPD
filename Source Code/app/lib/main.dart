import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './firebase_options.dart';
import '/ui/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const WPD());
}

class WPD extends StatelessWidget {
  const WPD({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "WPD",
      home: HomePage(),
    );
  }
}
