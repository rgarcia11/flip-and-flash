import 'package:flip_and_flash/core/models/deck_model.dart';

class CategoryModel {
  String name;
  String? backsideLanguage;
  String? frontsideLanguage;
  List<DeckModel>? decks;

  CategoryModel(this.name, this.frontsideLanguage, this.backsideLanguage,
      [this.decks]);
}
