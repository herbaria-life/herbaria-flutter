import 'package:flutter/material.dart';

import 'pages/login.dart';

void main() => runApp(HerbariaApp());

class HerbariaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Herbaria',
      home: LoginPage(),
    );
  }
}
