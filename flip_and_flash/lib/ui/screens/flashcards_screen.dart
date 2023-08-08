import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/providers/flashcard_provider.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flip_and_flash/ui/screens/create_edit_flashcard_screen.dart';
import 'package:flip_and_flash/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FlashcardsScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;
  final List<int> flashcardsIndices;
  final bool studyMode;
  final bool flip;

  const FlashcardsScreen(
      {required this.categoryId,
      required this.deckId,
      required this.flashcardsIndices,
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
  double? _currentSliderValue;
  final DatabaseService _db = DatabaseService();

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    flip = widget.flip;
    // _currentSliderValue = widget.flashcards.first.learned!.toDouble();
    _currentSliderValue = 0;
    flutterTts.setVolume(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardProvider>(builder:
        (BuildContext context, FlashcardProvider flashcardProvider, _) {
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
                                _currentSliderValue = flashcardProvider
                                    .flashcards[widget
                                        .flashcardsIndices[_currentCardIndex]]
                                    .learned!
                                    .toDouble();
                              });
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                    FloatingActionButton(
                      heroTag: "fab2hero",
                      onPressed: () {
                        if (_currentCardIndex ==
                            widget.flashcardsIndices.length - 1) {
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            _currentCardIndex += 1;
                            _currentSliderValue = flashcardProvider
                                .flashcards[
                                    widget.flashcardsIndices[_currentCardIndex]]
                                .learned!
                                .toDouble();
                          });
                        }
                        _db.editFlashcard(
                          widget.categoryId,
                          widget.deckId,
                          flashcardProvider
                              .flashcards[
                                  widget.flashcardsIndices[_currentCardIndex]]
                              .id!,
                          FlashcardModel(
                            backside: flashcardProvider
                                .flashcards[
                                    widget.flashcardsIndices[_currentCardIndex]]
                                .backside,
                            frontside: flashcardProvider
                                .flashcards[
                                    widget.flashcardsIndices[_currentCardIndex]]
                                .frontside,
                            learned: _currentSliderValue!.toInt(),
                          ),
                        );
                      },
                      child: Icon(
                        _currentCardIndex == widget.flashcardsIndices.length - 1
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
                    flashcardProvider
                        .flashcards[widget.flashcardsIndices[_currentCardIndex]]
                        .id!,
                    flashcardProvider.flashcards[
                        widget.flashcardsIndices[_currentCardIndex]]);
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  // TODO: languages come from elsewhere
                  // flutterTts.setLanguage(flip ? "ko-KR" : "en-US");
                  flutterTts.setLanguage("ko-KR");
                  // flutterTts.setLanguage("en-US");
                  await flutterTts.speak(flashcardProvider
                      .flashcards[widget.flashcardsIndices[_currentCardIndex]]
                      .backside);
                },
                icon: const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CreateEditFlashcardScreen(
                        categoryId: widget.categoryId,
                        deckId: widget.deckId,
                        edit: true,
                        flashcard: flashcardProvider.flashcards[
                            widget.flashcardsIndices[_currentCardIndex]],
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
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
                          color: getLearnedColor(flashcardProvider
                              .flashcards[
                                  widget.flashcardsIndices[_currentCardIndex]]
                              .learned),
                        ),
                      ),
                      child: Center(
                        child: Text(flip
                            ? flashcardProvider
                                .flashcards[
                                    widget.flashcardsIndices[_currentCardIndex]]
                                .backside
                            : flashcardProvider
                                .flashcards[
                                    widget.flashcardsIndices[_currentCardIndex]]
                                .frontside),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("How well have you learned this card?"),
                const SizedBox(height: 50),
                Slider(
                  value: flashcardProvider
                      .flashcards[widget.flashcardsIndices[_currentCardIndex]]
                      .learned!
                      .toDouble(),
                  max: 100,
                  divisions: 4,
                  label: flashcardProvider
                              .flashcards[
                                  widget.flashcardsIndices[_currentCardIndex]]
                              .learned !=
                          null
                      ? "${flashcardProvider.flashcards[widget.flashcardsIndices[_currentCardIndex]].learned!.toString()}%"
                      : "0%",
                  onChangeEnd: (value) {
                    FlashcardModel editedFlashcard = FlashcardModel(
                        frontside: flashcardProvider
                            .flashcards[
                                widget.flashcardsIndices[_currentCardIndex]]
                            .frontside,
                        backside: flashcardProvider
                            .flashcards[
                                widget.flashcardsIndices[_currentCardIndex]]
                            .backside,
                        learned: value.toInt());
                    _db.editFlashcard(
                        widget.categoryId,
                        widget.deckId,
                        flashcardProvider
                            .flashcards[
                                widget.flashcardsIndices[_currentCardIndex]]
                            .id!,
                        editedFlashcard);
                  },
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ],
            ),
          ));
    });
  }
}
