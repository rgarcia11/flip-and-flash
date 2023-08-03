import 'package:firebase_core/firebase_core.dart';

class Config {
  static final String firebaseProjectId = Firebase.app().options.projectId;
  static const String firebaseRegion = 'us-central1';
  static final String baseApiUrl =
      'https://$firebaseRegion-$firebaseProjectId.cloudfunctions.net/api';
}
