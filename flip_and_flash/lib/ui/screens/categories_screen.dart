import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/providers/category_provider.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/widgets/dialogs/add_category_dialog.dart';
import 'package:flip_and_flash/ui/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  String newCategoryName = "";
  String? newCategoryFrontsideLanguage;
  String? newCategoryBacksideLanguage;

  final DatabaseService _db = DatabaseService();

  @override
  void initState() {
    super.initState();
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
      body: Consumer<CategoryProvider>(builder:
          (BuildContext context, CategoryProvider categoryProvider, _) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount),
            itemBuilder: (BuildContext context, index) {
              return categoryProvider.categories.isNotEmpty
                  ? Center(
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CategoryScreen(
                                  categoryId:
                                      categoryProvider.categories[index].id!,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 300,
                            height: 300,
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child:
                                  Text(categoryProvider.categories[index].name),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container();
            },
            itemCount: categoryProvider.categories.isNotEmpty
                ? categoryProvider.categories.length
                : 0);
      }),
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
              },
              frontsideLanguageOnChanged: (String? value) {
                newCategoryFrontsideLanguage = value!;
                setState(() {
                  newCategoryFrontsideLanguage;
                });
              },
              backsideLanguageOnChanged: (String? value) {
                newCategoryBacksideLanguage = value!;
                setState(() {
                  newCategoryBacksideLanguage;
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
