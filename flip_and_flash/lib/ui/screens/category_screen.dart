import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/providers/deck_provider.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/edit_category_screen.dart';
import 'package:flip_and_flash/ui/widgets/dialogs/add_deck_dialog.dart';
import 'package:flip_and_flash/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryScreen({required this.category, super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final int crossAxisCount = 2;

  String newDeckName = "";

  final DatabaseService _db = DatabaseService();

  @override
  void initState() {
    super.initState();
    context.read<DeckProvider>().createDecksStream(widget.category.id!);
  }

  @override
  void dispose() {
    super.dispose();
    context.read<DeckProvider>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddDeckDialog(
                  textFieldOnChanged: (value) {
                    setState(() {
                      newDeckName = value!;
                    });
                  },
                  submitDialog: () {
                    _db.createDeck(
                        widget.category.id!,
                        DeckModel(
                          name: newDeckName,
                        ));
                    Navigator.of(context).pop();
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Decks in ${widget.category.name}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        EditCategoryScreen(category: widget.category)),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Consumer<DeckProvider>(
          builder: (BuildContext context, DeckProvider deckProvider, _) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount),
            itemBuilder: (BuildContext context, index) {
              return deckProvider.decks.isNotEmpty
                  ? DeckCard(
                      categoryId: widget.category.id!,
                      deck: deckProvider.decks[index],
                    )
                  : Container();
            },
            itemCount:
                deckProvider.decks.isNotEmpty ? deckProvider.decks.length : 0);
      }),
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
                  deck: deck,
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
