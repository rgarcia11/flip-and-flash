import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/ui/screens/create_edit_flashcard_screen.dart';
import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;
  final FlashcardModel flashcard;
  const FlashcardScreen(
      {required this.categoryId,
      required this.deckId,
      required this.flashcard,
      super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final int crossAxisCount = 2;
  bool flip = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flashcard'), actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CreateFlashcardScreen(
                    categoryId: widget.categoryId,
                    deckId: widget.deckId,
                    edit: true,
                    flashcard: widget.flashcard,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ]),
        body: Center(
          child: Card(
            child: InkWell(
              onTap: () {
                setState(() {
                  flip = !flip;
                });
              },
              child: Container(
                width: 300,
                height: 300,
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(flip
                      ? widget.flashcard.frontside
                      : widget.flashcard.backside),
                ),
              ),
            ),
          ),
        ));
  }
}
