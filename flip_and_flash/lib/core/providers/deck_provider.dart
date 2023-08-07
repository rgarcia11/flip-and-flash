import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/widgets.dart';

class DeckProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<DeckModel> decks = [];

  void _init(String categoryId) {
    _db.getDecksStream(categoryId).listen((event) {
      decks = event.docs.map((e) => DeckModel.fromSnapshot(e)).toList();
      notifyListeners();
    });
  }

  void createDecksStream(String categoryId) {
    _init(categoryId);
  }

  void _terminate() async {
    decks = [];
  }

  @override
  void dispose() {
    super.dispose();
    _terminate();
  }
}
