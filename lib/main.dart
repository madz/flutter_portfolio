import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_examples/pages/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.blue, fontFamily: 'OpenSans'),
      home: LoadingPage(),
    );
  }
}
