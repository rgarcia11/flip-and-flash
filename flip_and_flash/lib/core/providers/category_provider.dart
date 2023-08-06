import 'dart:async';

import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/widgets.dart';

class CategoryProvider extends ChangeNotifier {
  final DatabaseService _db = DatabaseService();
  List<CategoryModel> categories = [];

  Future<List<CategoryModel>> getAllCategories() async {
    categories = await _db.getAllCategories();
    notifyListeners();
    return categories;
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
