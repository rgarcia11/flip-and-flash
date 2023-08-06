import 'dart:async';

import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/widgets.dart';

class FlashcardProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<FlashcardModel> flashcards = [];

  Future<List<FlashcardModel>> getAllFlashcards(
      String categoryId, String deckId) async {
    flashcards = await _db.getAllFlashcards(categoryId, deckId);
    notifyListeners();
    return flashcards;
  }

  void _terminate() async {
    flashcards = [];
  }

  @override
  void dispose() {
    super.dispose();
    _terminate();
  }
}
