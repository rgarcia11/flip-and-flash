import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/flashcard_screen.dart';
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

  void initialFetch() async {
    DatabaseService db = DatabaseService();
    flashcards = await db.getAllFlashcards(widget.categoryId, widget.deckId);
    setState(() {});

    for (FlashcardModel flashcard in flashcards!) {
      print("GATOOOOOOO 5");
      print(flashcards);
      print(flashcard);
      print(flashcard.id);
      print(flashcard.frontside);
      print(flashcard.backside);
    }
  }

  @override
  void initState() {
    super.initState();
    initialFetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return flashcards != null
                ? FlashcardCard(
                    flashcard: flashcards![index],
                  )
                : const FlashcardCard();
          },
          itemCount: flashcards != null ? flashcards!.length : 0),
    );
  }
}

class FlashcardCard extends StatelessWidget {
  final FlashcardModel? flashcard;
  const FlashcardCard({this.flashcard, super.key});

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
              child: Text(flashcard != null ? flashcard!.frontside : ''),
            ),
          ),
        ),
      ),
    );
  }
}
