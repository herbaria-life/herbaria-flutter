import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../settings.dart' as Herbaria;
import '../amplifyconfiguration.dart';

// AmplifyController expects an Amplify Class that can be used during
// authentication or any other configuration. AmplifyController abstracts
// the usage of Amplify so that it can be stored as a provider, decoupling
// our widgets from Amplify itself.
class AmplifyController {
  AmplifyController({@required this.amplify});
  final AmplifyClass amplify;
  bool isConfigured = false;

  Future<bool> isLoggedIn() async {
    if (!isConfigured) {
      Herbaria.logger.w("You must call configure() first.");
      return false;
    }

    CognitoAuthSession session = await amplify.Auth.fetchAuthSession();
    return session.isSignedIn;
  }

  // Initialize Amplify library to provide AWS
  // functionality such as DataStorage, GraphQL API and Auth
  Future<void> configure() async {
    if (isConfigured) {
      Herbaria.logger.w("Amplify configure() already called.");
      return;
    }
    // Add DataStore plugin with given ModelProvider
    amplify.addPlugin(AmplifyAuthCognito());

    // Log authentication states
    amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case 'SIGNED_IN':
          Herbaria.logger.d("Signed in!");
          break;
        case 'SIGNED_OUT':
          Herbaria.logger.d("Signed out!");
          break;
        case 'SESSION_EXPIRED':
          Herbaria.logger.d("Session Expired!");
          break;
      }
    });

    try {
      await amplify.configure(amplifyconfig);
      isConfigured = true;
    } on AmplifyAlreadyConfiguredException {
      Herbaria.logger.d(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    } on AmplifyException catch (e) {
      Herbaria.logger.e("Unable to configure Amplify", e);
    }
  }
}
