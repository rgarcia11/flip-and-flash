import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/widgets/dialogs/add_category_dialog.dart';
import 'package:flip_and_flash/ui/screens/category_screen.dart';
import 'package:flutter/material.dart';

const List<String> languagesList = <String>['English', 'Korean'];

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final int crossAxisCount = 2;
  late List<FlashcardModel> cards;
  late List<DeckModel> decks;
  List<CategoryModel>? categories;

  String newCategoryName = "";
  String? newCategoryFrontsideLanguage;
  String? newCategoryBacksideLanguage;

  final DatabaseService _db = DatabaseService();

  void initialFetch() async {
    categories = await _db.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialFetch();
    newCategoryFrontsideLanguage ??=
        newCategoryFrontsideLanguage = languagesList.first;
    newCategoryBacksideLanguage ??= languagesList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCategoryDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Categories')),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return categories != null
                ? CategoryCard(
                    category: categories![index],
                  )
                : Container();
          },
          itemCount: categories != null ? categories!.length : 0),
    );
  }

  void _showAddCategoryDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddCategoryDialog(
              newCategoryFrontsideLanguage: newCategoryFrontsideLanguage!,
              newCategoryBacksideLanguage: newCategoryBacksideLanguage!,
              languagesList: languagesList,
              textFieldOnChanged: (value) {
                setState(() {
                  newCategoryName = value!;
                });
                print(newCategoryName);
              },
              frontsideLanguageOnChanged: (String? value) {
                newCategoryFrontsideLanguage = value!;
                setState(() {
                  newCategoryFrontsideLanguage;
                  print(newCategoryFrontsideLanguage);
                });
              },
              backsideLanguageOnChanged: (String? value) {
                newCategoryBacksideLanguage = value!;
                setState(() {
                  newCategoryBacksideLanguage;
                  print(newCategoryBacksideLanguage);
                });
              },
              submitDialog: () {
                _db.createCategory(CategoryModel(
                  name: newCategoryName,
                  frontsideLanguage: newCategoryFrontsideLanguage,
                  backsideLanguage: newCategoryBacksideLanguage,
                ));
                Navigator.of(context).pop();
              });
        });
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CategoryCard({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    CategoryScreen(
                  categoryId: category.id!,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(category.name),
            ),
          ),
        ),
      ),
    );
  }
}
