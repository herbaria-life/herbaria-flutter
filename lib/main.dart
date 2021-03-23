import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'screens/home.dart';
import 'screens/login.dart';
import 'helpers/amplify.dart';
import 'settings.dart' as Herbaria;

void main() async {
  // Calling this method is required when work is executed before calling `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the logger so that it can be attached to the entire application
  Herbaria.logger = Logger();

  // Initialize AmplifyController that manages any interaction with Amplify
  Herbaria.amplifyController = AmplifyController(amplify: Amplify);

  // Configure Amplify and check if the login process has been executed in the past
  await Herbaria.amplifyController.configure();
  bool isLoggedIn = await Herbaria.amplifyController.isLoggedIn();

  return runApp(HerbariaApp(isLoggedIn: isLoggedIn));
}

class HerbariaApp extends StatelessWidget {
  HerbariaApp({@required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
