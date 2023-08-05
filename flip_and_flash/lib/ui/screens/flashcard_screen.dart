import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/ui/screens/create_edit_flashcard_screen.dart';
import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;
  final FlashcardModel flashcard;
  final bool studyMode;

  const FlashcardScreen(
      {required this.categoryId,
      required this.deckId,
      required this.flashcard,
      this.studyMode = false,
      super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final int crossAxisCount = 2;
  bool flip = false;
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: widget.studyMode
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 50),
                  FloatingActionButton(
                    heroTag: "fab1hero",
                    onPressed: () {},
                    child: const Icon(Icons.arrow_back),
                  ),
                  FloatingActionButton(
                    heroTag: "fab2hero",
                    onPressed: () {},
                    child: const Icon(Icons.arrow_forward),
                  ),
                  const SizedBox(width: 50)
                ],
              )
            : null,
        appBar: AppBar(
          title: const Text('Flashcard'),
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
                      flashcard: widget.flashcard,
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
                  child: Center(
                    child: Text(flip
                        ? widget.flashcard.frontside
                        : widget.flashcard.backside),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150),
            const Text("How well have you learnt this card?"),
            const SizedBox(height: 50),
            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 5,
              label: "${_currentSliderValue.round().toString()}%",
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
          ],
        ));
  }
}
