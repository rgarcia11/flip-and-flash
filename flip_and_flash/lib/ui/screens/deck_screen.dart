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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              newCardFrontside = value;
                            });
                          },
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              newCardBackside = value;
                            });
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            _db.createFlashcard(
                                widget.categoryId,
                                widget.deckId,
                                FlashcardModel(
                                  frontside: newCardFrontside,
                                  backside: newCardBackside,
                                ));
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.school),
      ),
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
