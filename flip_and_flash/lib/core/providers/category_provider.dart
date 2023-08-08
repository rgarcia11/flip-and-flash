import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/widgets.dart';

class CategoryProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<CategoryModel> categories = [];
  Map<String, CategoryModel> categoriesById = {};

  CategoryProvider() {
    _init();
  }

  void _init() {
    _db.getCategoriesStream().listen((event) {
      categories =
          event.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      categoriesById = event.docs.fold<Map<String, CategoryModel>>(
          categoriesById, (Map<String, CategoryModel> categoriesMap,
              DocumentSnapshot<Map<String, dynamic>> snapshot) {
        CategoryModel category = CategoryModel.fromSnapshot(snapshot);
        categoriesMap[category.id!] = category;
        return categoriesMap;
      });
      notifyListeners();
    });
  }

  void _terminate() async {
    categories = [];
  }

  @override
  void dispose() {
    super.dispose();
    _terminate();
  }
}
