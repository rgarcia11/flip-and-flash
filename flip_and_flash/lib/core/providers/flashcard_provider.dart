import 'dart:math';

import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/widgets.dart';

class FlashcardProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<FlashcardModel> flashcards = [];
  late List<FlashcardModel> activeFlashcards;

  void _init(String categoryId, String deckId) {
    _db.getFlashcardsStream(categoryId, deckId).listen((event) {
      flashcards =
          event.docs.map((e) => FlashcardModel.fromSnapshot(e)).toList();
      notifyListeners();
    });
  }

  void createFlashcardsStream(String categoryId, String deckId) {
    _init(categoryId, deckId);
  }

  List<FlashcardModel> setActiveFlashcards(List<FlashcardModel> flashcards) {
    activeFlashcards = flashcards;
    notifyListeners();
    return activeFlashcards;
  }

  List<int> formStudyFlashcards(int num) {
    List<int> flashcardsIndices = [];
    while (flashcardsIndices.length < num) {
      int rD = Random().nextInt(15);
      int rI = Random().nextInt(flashcards.length);
      bool add = false;
      if (rD <= 4 && flashcards[rI].learned == 0 ||
          flashcards[rI].learned == null) {
        add = true;
      }
      if (rD >= 5 && rD <= 8 && flashcards[rI].learned == 25) {
        add = true;
      }
      if (rD >= 9 && rD <= 11 && flashcards[rI].learned == 50) {
        add = true;
      }
      if (rD >= 12 && rD <= 13 && flashcards[rI].learned == 75) {
        add = true;
      }
      if (rD == 14 && flashcards[rI].learned == 100) {
        add = true;
      }
      if (add) {
        flashcardsIndices.add(rI);
      }
    }
    return flashcardsIndices;
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
