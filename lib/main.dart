import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'pages/login.dart';
import 'helpers/amplify.dart';
import 'settings.dart' as Herbaria;

void main() => runApp(HerbariaApp());

class HerbariaApp extends StatelessWidget {
  HerbariaApp() {
    // Calling this method is required when work is executed before calling `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize the logger so that it can be attached to the entire application
    Herbaria.logger = Logger();

    // Initialize AmplifyController that manages any interaction with Amplify
    Herbaria.amplifyController = AmplifyController(amplify: Amplify);
    Herbaria.amplifyController.configure();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
      },
    );
  }
}
