import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/create_edit_flashcard_screen.dart';
import 'package:flip_and_flash/ui/screens/edit_deck_screen.dart';
import 'package:flip_and_flash/ui/screens/flashcard_screen.dart';
import 'package:flip_and_flash/ui/widgets/expandable_fab.dart';
import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  final String categoryId;
  final DeckModel deck;
  const DeckScreen({required this.categoryId, required this.deck, super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  List<FlashcardModel>? flashcards;
  final int crossAxisCount = 3;

  String newCardFrontside = "";
  String newCardBackside = "";

  final DatabaseService _db = DatabaseService();

  void initialFetch() async {
    flashcards = await _db.getAllFlashcards(widget.categoryId, widget.deck.id!);
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
      // TODO: Swap for flow: https://api.flutter.dev/flutter/widgets/Flow-class.html
      floatingActionButton: ExpandableFab(
        distance: 200,
        children: [
          FloatingActionButton.extended(
            heroTag: "innerFab1",
            label: const Text("Study 1 card"),
            onPressed: () {
              // TODO: select 20 random cards
              // TODO: not so random... select more frequently the ones least learned
              // TODO: make a mechanism that allows for back to back FlashcardScreens when popping or navigating
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FlashcardScreen(
                    categoryId: widget.categoryId,
                    deckId: widget.deck.id!,
                    flashcard: flashcards!.first,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.school),
          ),
          FloatingActionButton.extended(
            heroTag: "innerFab2",
            label: const Text("Study 10 cards"),
            onPressed: () {
              // TODO: select 20 random cards
              // TODO: not so random... select more frequently the ones least learned
              // TODO: make a mechanism that allows for back to back FlashcardScreens when popping or navigating
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FlashcardScreen(
                    categoryId: widget.categoryId,
                    deckId: widget.deck.id!,
                    flashcard: flashcards!.first,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.school),
          ),
          FloatingActionButton.extended(
            heroTag: "innerFab3",
            label: const Text("Study 20 cards"),
            onPressed: () {
              // TODO: select 20 random cards
              // TODO: not so random... select more frequently the ones least learned
              // TODO: make a mechanism that allows for back to back FlashcardScreens when popping or navigating
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FlashcardScreen(
                    categoryId: widget.categoryId,
                    deckId: widget.deck.id!,
                    flashcard: flashcards!.first,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.school),
          ),
          FloatingActionButton(
            heroTag: "innerFab4",
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CreateEditFlashcardScreen(
                          categoryId: widget.categoryId,
                          deckId: widget.deck.id!)));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Flashcards in ${widget.deck.name}'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      EditDeckScreen(
                          categoryId: widget.categoryId, deck: widget.deck),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return flashcards != null
                ? FlashcardCard(
                    categoryId: widget.categoryId,
                    deckId: widget.deck.id!,
                    flashcard: flashcards![index],
                  )
                : const Placeholder();
          },
          itemCount: flashcards != null ? flashcards!.length : 0),
    );
  }
}

class FlashcardCard extends StatelessWidget {
  final String categoryId;
  final String deckId;
  final FlashcardModel flashcard;
  const FlashcardCard(
      {required this.categoryId,
      required this.deckId,
      required this.flashcard,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FlashcardScreen(
                  categoryId: categoryId,
                  deckId: deckId,
                  flashcard: flashcard,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(flashcard.frontside),
            ),
          ),
        ),
      ),
    );
  }
}
