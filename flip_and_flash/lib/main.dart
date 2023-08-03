// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flip_and_flash/ui/screens/categories_screen.dart';
import 'package:flutter/material.dart';

void main() {
  // Initializing firebase application options
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Setting firebaseAuth tenandId for clients
  // FirebaseAuth.instance.tenantId = Config.env.tenantId;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flip and Flash',
      home: CategoriesScreen(),
    );
  }
}
