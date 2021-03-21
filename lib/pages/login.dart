import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// LoginPage allows users to access via Google Authentication
class LoginPage extends StatelessWidget {

  Future<void> login() async {
    Logger logger = Logger();
    try {
      await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);
    } on AmplifyException catch (e) {
      logger.e("Authentication failed", e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      // Full-screen image
      Image(
        image: AssetImage("assets/login_full_screen_image.png"),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
      // Title
      Container(
        margin: const EdgeInsets.only(bottom: 100.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'Herbaria',
            style: TextStyle(
                fontSize: 90.0, fontFamily: 'BadScript', color: Colors.white),
          ),
        ),
      ),
      // Container to create a fade effect
      Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.20),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 50.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            heightFactor: 0.06,
            widthFactor: 0.8,
            child: ElevatedButton(
              child: Text('Sign-in with Google',
                  style: TextStyle(color: Colors.white)),
              onPressed: login,
            ),
          ),
        ),
      ),
    ]));
  }
}
