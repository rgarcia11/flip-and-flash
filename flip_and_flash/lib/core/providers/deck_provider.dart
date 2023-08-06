import 'dart:async';

import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/widgets.dart';

class DeckProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<DeckModel> decks = [];

  Future<List<DeckModel>> getAllDecks(String categoryId) async {
    decks = await _db.getAllDecks(categoryId);
    notifyListeners();
    return decks;
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
