import 'package:flutter/material.dart';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import '../config/amplifyconfiguration.dart';
import '../logger.dart';

final log = getLogger('AmplifyController');

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
      log.w("You must call configure() first.");
      return false;
    }

    try {
      CognitoAuthSession session = await amplify.Auth.fetchAuthSession();
      return session.isSignedIn;
    } on NotAuthorizedException catch (e) {
      log.d("User is not authenticated. Unauthenticated access is not allowed");
      return false;
    }
  }

  // Initialize Amplify library to provide AWS
  // functionality such as DataStorage, GraphQL API and Auth
  Future<void> configure() async {
    if (isConfigured) {
      log.w("Amplify configure() already called.");
      return;
    }
    // Add DataStore plugin with given ModelProvider
    amplify.addPlugin(AmplifyAuthCognito());

    // Log authentication states
    amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case 'SIGNED_IN':
          log.d("Signed in!");
          break;
        case 'SIGNED_OUT':
          log.d("Signed out!");
          break;
        case 'SESSION_EXPIRED':
          log.d("Session Expired!");
          break;
      }
    });

    try {
      await amplify.configure(amplifyconfig);
      isConfigured = true;
    } on AmplifyAlreadyConfiguredException {
      log.d(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
      isConfigured = true;
    } on AmplifyException catch (e) {
      log.e("Unable to configure Amplify", e);
    }
  }
}
