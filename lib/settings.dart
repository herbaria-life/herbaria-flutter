library settings;

import 'package:logger/logger.dart';
import 'helpers/amplify.dart';

// Settings used in the entire application. A Provider is not used because
// settings available in this module are not meant to be used to render widgets
// or to change during the execution of the application. If you need to attach
// a widget status to these variables, use a `Provider` instead.
Logger logger;
AmplifyController amplifyController;
