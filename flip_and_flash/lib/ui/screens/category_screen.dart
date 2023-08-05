import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/widgets/dialogs/add_deck_dialog.dart';
import 'package:flip_and_flash/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryScreen({required this.category, super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<DeckModel>? decks;
  final int crossAxisCount = 2;

  String newDeckName = "";

  final DatabaseService _db = DatabaseService();

  void initialFetch() async {
    decks = await _db.getAllDecks(widget.category.id!);
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
              // TODO: Edit category
              // Navigator.of(context).push(
              //   PageRouteBuilder(
              //     pageBuilder: (context, animation, secondaryAnimation) =>
              //         CreateFlashcardScreen(
              //       categoryId: widget.categoryId,
              //       deckId: widget.deckId,
              //       edit: true,
              //       flashcard: widget.flashcard,
              //     ),
              //   ),
              // );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return decks != null
                ? DeckCard(
                    categoryId: widget.category.id!,
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
