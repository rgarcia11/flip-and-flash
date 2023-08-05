import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/create_edit_flashcard_screen.dart';
import 'package:flip_and_flash/ui/screens/flashcard_screen.dart';
import 'package:flip_and_flash/ui/widgets/expandable_fab.dart';
import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;
  const DeckScreen({required this.categoryId, required this.deckId, super.key});

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
    flashcards = await _db.getAllFlashcards(widget.categoryId, widget.deckId);
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
      floatingActionButton: ExpandableFab(
        distance: 150,
        children: [
          FloatingActionButton(
            heroTag: "innerFab1",
            onPressed: () {
              // TODO: Study screen! (Flashcard scren with a twist)
            },
            child: const Icon(Icons.school),
          ),
          FloatingActionButton(
            heroTag: "innerFab2",
            onPressed: () {
              // TODO: Study screen! (Flashcard scren with a twist)
            },
            child: const Icon(Icons.school),
          ),
          FloatingActionButton(
            heroTag: "innerFab3",
            onPressed: () {
              // TODO: Study screen! (Flashcard scren with a twist)
            },
            child: const Icon(Icons.school),
          ),
          FloatingActionButton(
            heroTag: "innerFab4",
            onPressed: () {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CreateFlashcardScreen(
                          categoryId: widget.categoryId,
                          deckId: widget.deckId)));
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      appBar: AppBar(title: const Text('Flashcards')),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return flashcards != null
                ? FlashcardCard(
                    categoryId: widget.categoryId,
                    deckId: widget.deckId,
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
