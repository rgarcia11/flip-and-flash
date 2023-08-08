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
      categoriesById = {
        for (final snapshot in event.docs)
          snapshot.id: CategoryModel.fromSnapshot(snapshot)
      };
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
