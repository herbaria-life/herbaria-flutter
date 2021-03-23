import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

import 'logger.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'helpers/amplify.dart';
import 'settings.dart' as Herbaria;

final log = getLogger("main.dart");

void main() async {
  // Calling this method is required when work is executed before calling `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AmplifyController that manages any interaction with Amplify
  Herbaria.amplifyController = AmplifyController(amplify: Amplify);

  // Configure Amplify and check if the login process has been executed in the past
  await Herbaria.amplifyController.configure();
  bool isLoggedIn = await Herbaria.amplifyController.isLoggedIn();
  log.d("Logged in status: $isLoggedIn");

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
