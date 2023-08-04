import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';

class DeckModel {
  String? id;
  String name;
  List<FlashcardModel>? cards;

  DeckModel({this.id, required this.name, this.cards});

  toJson() {
    return {
      "Name": name,
    };
  }

  factory DeckModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!; // TODO: THIS WILL FAIL
    return DeckModel(
      id: document.id,
      name: data["Name"],
    );
  }
}
