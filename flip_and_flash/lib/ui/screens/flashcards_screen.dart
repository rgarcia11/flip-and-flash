import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/create_edit_flashcard_screen.dart';
import 'package:flip_and_flash/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';

class FlashcardsScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;
  final List<FlashcardModel> flashcards;
  final bool studyMode;
  final bool flip;

  const FlashcardsScreen(
      {required this.categoryId,
      required this.deckId,
      required this.flashcards,
      this.studyMode = true,
      this.flip = false,
      super.key});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  final int crossAxisCount = 2;
  late bool flip;
  int _currentCardIndex = 0;
  double _currentSliderValue = 0;
  final DatabaseService _db = DatabaseService();

  @override
  void initState() {
    super.initState();
    flip = widget.flip;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: widget.studyMode
              ? [
                  const SizedBox(width: 50),
                  _currentCardIndex == 0
                      ? Container()
                      : FloatingActionButton(
                          heroTag: "fab1hero",
                          onPressed: () {
                            setState(() {
                              _currentCardIndex -= 1;
                            });
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
                  FloatingActionButton(
                    heroTag: "fab2hero",
                    onPressed: () {
                      if (_currentCardIndex == widget.flashcards.length - 1) {
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          _currentCardIndex += 1;
                        });
                      }
                      _db.editFlashcard(
                        widget.categoryId,
                        widget.deckId,
                        widget.flashcards[_currentCardIndex].id!,
                        FlashcardModel(
                          backside:
                              widget.flashcards[_currentCardIndex].backside,
                          frontside:
                              widget.flashcards[_currentCardIndex].frontside,
                          learned: _currentSliderValue.toInt(),
                        ),
                      );
                    },
                    child: Icon(
                      _currentCardIndex == widget.flashcards.length - 1
                          ? Icons.exit_to_app
                          : Icons.arrow_forward,
                    ),
                  ),
                  const SizedBox(width: 50)
                ]
              : [],
        ),
        appBar: AppBar(
          title: const Text('Flashcard'),
          leading: BackButton(
            onPressed: () {
              _db.editFlashcard(
                  widget.categoryId,
                  widget.deckId,
                  widget.flashcards[_currentCardIndex].id!,
                  widget.flashcards[_currentCardIndex]);
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CreateEditFlashcardScreen(
                      categoryId: widget.categoryId,
                      deckId: widget.deckId,
                      edit: true,
                      flashcard: widget.flashcards[_currentCardIndex],
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
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
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: getLearnedColor(
                          widget.flashcards[_currentCardIndex].learned),
                    ),
                  ),
                  child: Center(
                    child: Text(flip
                        ? widget.flashcards[_currentCardIndex].backside
                        : widget.flashcards[_currentCardIndex].frontside),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150),
            const Text("How well have you learned this card?"),
            const SizedBox(height: 50),
            Slider(
              value: widget.flashcards[_currentCardIndex].learned != null
                  ? widget.flashcards[_currentCardIndex].learned!.toDouble()
                  : 0,
              max: 100,
              divisions: 4,
              label: widget.flashcards[_currentCardIndex].learned != null
                  ? "${widget.flashcards[_currentCardIndex].learned!.toString()}%"
                  : "0%",
              onChanged: (double value) {
                setState(() {
                  widget.flashcards[_currentCardIndex].learned = value.toInt();
                  _currentSliderValue = value;
                });
              },
            ),
          ],
        ));
  }
}
