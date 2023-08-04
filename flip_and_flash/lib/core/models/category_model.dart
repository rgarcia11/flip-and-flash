import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';

class CategoryModel {
  String? id;
  String name;
  String? backsideLanguage;
  String? frontsideLanguage;
  List<DeckModel>? decks;

  CategoryModel(
      {this.id,
      required this.name,
      this.frontsideLanguage,
      this.backsideLanguage,
      this.decks});

  toJson() {
    return {
      "Name": name,
      "BacksideLanguage": backsideLanguage,
      "FrontsideLanguage": frontsideLanguage
    };
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!; // TODO: THIS WILL FAIL
    return CategoryModel(
      id: document.id,
      name: data["Name"],
      backsideLanguage: data["BacksideLanguage"],
      frontsideLanguage: data["FrontsideLanguage"],
    );
  }
}
