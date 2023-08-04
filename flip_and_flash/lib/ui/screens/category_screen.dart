import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final String categoryId;

  const CategoryScreen({required this.categoryId, super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<DeckModel>? decks;
  final int crossAxisCount = 2;

  void initialFetch() async {
    DatabaseService db = DatabaseService();
    decks = await db.getAllDecks(widget.categoryId);
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
      appBar: AppBar(title: const Text('Decks')),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return decks != null
                ? DeckCard(
                    categoryId: widget.categoryId,
                    deck: decks![index],
                  )
                : Container();
          },
          itemCount: decks != null ? decks!.length : 0),
    );
  }
}

class DeckCard extends StatelessWidget {
  final String categoryId;
  final DeckModel deck;
  const DeckCard({required this.categoryId, required this.deck, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DeckScreen(
                  categoryId: categoryId,
                  deckId: deck.id!,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(deck.name),
            ),
          ),
        ),
      ),
    );
  }
}
