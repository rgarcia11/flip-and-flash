import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/category_screen.dart';
import 'package:flutter/material.dart';

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

  void initialFetch() async {
    DatabaseService db = DatabaseService();
    categories = await db.getAllCategories();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
