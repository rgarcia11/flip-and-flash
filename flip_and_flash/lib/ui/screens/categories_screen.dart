import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
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
  late List<CategoryModel> categories;

  @override
  void initState() {
    // TODO: Fetch from Firebase
    super.initState();
    cards = [
      FlashcardModel('Travel(EN)', 'Travel(KR)'),
      FlashcardModel('Eat(EN)', 'Eat(KR)', 100),
      FlashcardModel('Sit(EN)', 'Sit(KR)', 80),
    ];
    decks = [
      DeckModel('Verbs', cards),
      DeckModel('Adjectives', cards),
      DeckModel('Prepositions', cards),
    ];
    categories = [
      CategoryModel('Korean', 'Korean', 'English', decks),
      CategoryModel('Como dilatar el ano', 'Korean', 'English'),
      CategoryModel('En serio, como me meto esos 40 cms de envergadura',
          'Korean', 'English'),
      CategoryModel('en verga dura juas', 'Korean', 'English'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return CategoryCard(
              category: categories[index],
            );
          },
          itemCount: categories.length),
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
                  decks: category.decks,
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
