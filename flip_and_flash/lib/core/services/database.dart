import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    final snapshot = await db.collection("categories").get();
    final categoryData =
        snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
    return categoryData;
  }

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

  Future<List<DeckModel>> getAllDecks(
    String categoryId,
  ) async {
    final snapshot = await db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .get();
    final deckData =
        snapshot.docs.map((e) => DeckModel.fromSnapshot(e)).toList();
    return deckData;
  }

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

  Future<List<FlashcardModel>> getAllFlashcards(
    String categoryId,
    String deckId,
  ) async {
    final snapshot = await db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .doc(deckId)
        .collection("cards")
        .get();
    final deckData =
        snapshot.docs.map((e) => FlashcardModel.fromSnapshot(e)).toList();
    return deckData;
  }

  void createFlashcard(
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

  void editFlashcard(
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
