// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_and_flash/core/providers/category_provider.dart';
import 'package:flip_and_flash/core/providers/deck_provider.dart';
import 'package:flip_and_flash/core/providers/flashcard_provider.dart';
import 'package:flip_and_flash/ui/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  // Initializing firebase application options
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Setting firebaseAuth tenandId for clients
  // FirebaseAuth.instance.tenantId = Config.env.tenantId;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => DeckProvider()),
        ChangeNotifierProvider(create: (_) => FlashcardProvider()),
      ],
      child: const MaterialApp(
        title: 'Flip and Flash',
        home: CategoriesScreen(),
      ),
    );
  }
}
