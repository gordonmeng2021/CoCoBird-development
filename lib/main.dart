import 'package:coocoobird_design/games/Mapping-shape.dart';
import 'package:coocoobird_design/games/cameragame.dart';
import 'package:coocoobird_design/games/huntinggames.dart';
import 'package:coocoobird_design/games/savingorange.dart';
import 'package:coocoobird_design/Mainscreen/DrawerScreen/Performance.dart';
import 'package:coocoobird_design/Mainscreen/DrawerScreen/Tracking.dart';
import 'package:coocoobird_design/Mainscreen/Mainscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'games/Mapping-animals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDefault();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/mapping_shape',
        routes: {
          '/': (context) => const xd_Mainscreen(),
          '/performance': (context) => const Performancepage(),
          '/tracking': (context) => TrackingPage(),
          '/mapping_shape': (context) => Mapping_shape(),
          '/mapping_animals': (context) => Mapping_animals(),
          '/cameraGame': (context) => CameraGame(),
          '/huntingGame': (context) => HuntingGame(),
          '/savingorange': (context) => SavingOrangeGame()
        },
        debugShowCheckedModeBanner: false);
  }
}

Future<void> initializeDefault() async {
  FirebaseApp app = await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:90263180856:ios:dd66809c6ae0919d5678cd',
      apiKey: 'AIzaSyCI50526KoRtkbZc8LVEQDLEL-1EIE32DE',
      projectId: 'cameratest-39e72',
      messagingSenderId: '118385592375',
    ),
  );
}
