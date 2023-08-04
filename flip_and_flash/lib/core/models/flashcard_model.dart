import 'package:cloud_firestore/cloud_firestore.dart';

class FlashcardModel {
  String? id;
  String frontside;
  String backside;
  int? learned;

  FlashcardModel(
      {this.id, required this.frontside, required this.backside, this.learned});

  toJson() {
    return {
      "Frontside": frontside,
      "Backside": backside,
      "Learned": learned,
    };
  }

  factory FlashcardModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!; // TODO: THIS WILL FAIL
    return FlashcardModel(
      id: document.id,
      frontside: data["Frontside"],
      backside: data["Backside"],
      learned: data["Learnedside"],
    );
  }
}
