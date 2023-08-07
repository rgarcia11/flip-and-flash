import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoriesStream() =>
      db.collection("categories").snapshots();

  void createCategory(
    CategoryModel newCategory,
  ) async {
    db.collection("categories").add(newCategory.toJson());
  }

  void editCategory(
    CategoryModel editedCategory,
  ) async {
    db
        .collection("categories")
        .doc(editedCategory.id)
        .update(editedCategory.toJson());
  }

  void deleteCategory(
    String deletedCategoryId,
  ) async {
    db.collection("categories").doc(deletedCategoryId).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getDecksStream(
          String categoryId) =>
      db
          .collection("categories")
          .doc(categoryId)
          .collection("decks")
          .snapshots();

  void createDeck(
    String categoryId,
    DeckModel newDeck,
  ) async {
    db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .add(newDeck.toJson());
  }

  void editDeck(
    String categoryId,
    DeckModel editedDeck,
  ) async {
    db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .doc(editedDeck.id)
        .update(editedDeck.toJson());
  }

  void deleteDeck(
    String categoryId,
    String deckId,
  ) async {
    db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .doc(deckId)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFlashcardsStream(
          String categoryId, String deckId) =>
      db
          .collection("categories")
          .doc(categoryId)
          .collection("decks")
          .doc(deckId)
          .collection("cards")
          .snapshots();

  Future<void> createFlashcard(
    String categoryId,
    String deckId,
    FlashcardModel newFlashcard,
  ) async {
    db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .doc(deckId)
        .collection("cards")
        .add(newFlashcard.toJson());
  }

  Future<void> editFlashcard(
    String categoryId,
    String deckId,
    String flashcardId,
    FlashcardModel editedFlashcard,
  ) async {
    db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .doc(deckId)
        .collection("cards")
        .doc(flashcardId)
        .update(editedFlashcard.toJson());
  }

  void deleteFlashcard(
    String categoryId,
    String deckId,
    String flashcardId,
  ) async {
    db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .doc(deckId)
        .collection("cards")
        .doc(flashcardId)
        .delete();
  }
}
