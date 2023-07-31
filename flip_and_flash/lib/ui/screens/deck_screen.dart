import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/ui/screens/flashcard_screen.dart';
import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  final List<FlashcardModel>? cards;
  const DeckScreen({this.cards, super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  final int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flashcards')),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return widget.cards != null
                ? FlashcardCard(
                    flashcard: widget.cards![index],
                  )
                : const FlashcardCard();
          },
          itemCount: widget.cards != null ? widget.cards!.length : 0),
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
