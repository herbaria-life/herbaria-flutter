import 'package:flutter/material.dart';

import 'helpers/amplify.dart';
import 'pages/login.dart';

void main() => runApp(HerbariaApp());

class HerbariaApp extends StatelessWidget {
  HerbariaApp() {
    // Initialize Amplify library to provide AWS
    // functionality such as DataStorage, GraphQL API and Auth
    WidgetsFlutterBinding.ensureInitialized();
    configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
