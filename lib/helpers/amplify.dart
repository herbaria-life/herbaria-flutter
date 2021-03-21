import 'package:logger/logger.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../amplifyconfiguration.dart';

void configureAmplify() async {
  Logger logger = Logger();

  // Add DataStore plugin with given ModelProvider
  Amplify.addPlugin(AmplifyAuthCognito());

  // Log authentication states
  Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
    switch (hubEvent.eventName) {
      case 'SIGNED_IN':
        logger.d("Signed in!");
        break;
      case 'SIGNED_OUT':
        logger.d("Signed out!");
        break;
      case 'SESSION_EXPIRED':
        logger.d("Session Expired!");
        break;
    }
  });

  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    logger.d(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  } on AmplifyException catch (e){
    logger.e("Unable to configure Amplify", e);
  }
}
