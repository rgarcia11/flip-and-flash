import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  // Create a new user with a first and last name
  final user = <String, dynamic>{
    "first": "Felipe",
    "last": "Castañeda",
    "born": 1989
  };

  void testAdd() {
    // Add a new document with a generated ID
    db.collection("users").add(user).then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
    });
  }

  void testRead() async {
    await db.collection("users").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
      }
    });
  }

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
    DeckModel newCategory,
  ) async {
    db
        .collection("categories")
        .doc(categoryId)
        .collection("decks")
        .add(newCategory.toJson());
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
