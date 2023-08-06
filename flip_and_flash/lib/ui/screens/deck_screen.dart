import 'dart:math';

import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/providers/flashcard_provider.dart';
import 'package:flip_and_flash/ui/screens/create_edit_flashcard_screen.dart';
import 'package:flip_and_flash/ui/screens/edit_deck_screen.dart';
import 'package:flip_and_flash/ui/screens/flashcards_screen.dart';
import 'package:flip_and_flash/ui/widgets/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeckScreen extends StatefulWidget {
  final String categoryId;
  final DeckModel deck;
  const DeckScreen({required this.categoryId, required this.deck, super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  final int crossAxisCount = 3;
  bool flip = false;

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
              List<FlashcardModel> flashcardList = formStudyFlashcards(1);
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FlashcardsScreen(
                    categoryId: widget.categoryId,
                    deckId: widget.deck.id!,
                    flashcards: flashcardList,
                    flip: flip,
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
              List<FlashcardModel> flashcardList = formStudyFlashcards(10);
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FlashcardsScreen(
                    categoryId: widget.categoryId,
                    deckId: widget.deck.id!,
                    flashcards: flashcardList,
                    flip: flip,
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
              List<FlashcardModel> flashcardList = formStudyFlashcards(20);
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FlashcardsScreen(
                    categoryId: widget.categoryId,
                    deckId: widget.deck.id!,
                    flashcards: flashcardList,
                    flip: flip,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.school),
          ),
          FloatingActionButton(
            heroTag: "innerFab4",
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      CreateEditFlashcardScreen(
                          categoryId: widget.categoryId,
                          deckId: widget.deck.id!),
                ),
              );
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
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        ListTile(
                          title: const Text('Edit deck'),
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        EditDeckScreen(
                                            categoryId: widget.categoryId,
                                            deck: widget.deck),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text('Add flashcard'),
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CreateEditFlashcardScreen(
                                            categoryId: widget.categoryId,
                                            deckId: widget.deck.id!),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: const Text("Flip side"),
                          onTap: () {
                            setState(() {
                              flip = !flip;
                            });
                          },
                        ),
                        const ListTile(),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.segment),
          ),
        ],
      ),
      body: Consumer<FlashcardProvider>(builder:
          (BuildContext context, FlashcardProvider flashcardProvider, _) {
        flashcardProvider.getAllFlashcards(widget.categoryId, widget.deck.id!);
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount),
            itemBuilder: (BuildContext context, index) {
              return flashcardProvider.flashcards.isNotEmpty
                  ? FlashcardCard(
                      categoryId: widget.categoryId,
                      deckId: widget.deck.id!,
                      flashcard: flashcardProvider.flashcards[index],
                      flip: flip,
                    )
                  : const Placeholder();
            },
            itemCount: flashcardProvider.flashcards.isNotEmpty
                ? flashcardProvider.flashcards.length
                : 0);
      }),
    );
  }

  List<FlashcardModel> formStudyFlashcards(int num) {
    List<FlashcardModel> flashcardList = [];
    List<FlashcardModel> flashcards =
        Provider.of<FlashcardProvider>(context, listen: false).flashcards;
    while (flashcardList.length < num) {
      int rD = Random().nextInt(15);
      int rI = Random().nextInt(flashcards.length);
      bool add = false;
      if (rD <= 4 && flashcards[rI].learned == 0 ||
          flashcards[rI].learned == null) {
        add = true;
      }
      if (rD >= 5 && rD <= 8 && flashcards[rI].learned == 25) {
        add = true;
      }
      if (rD >= 9 && rD <= 11 && flashcards[rI].learned == 50) {
        add = true;
      }
      if (rD >= 12 && rD <= 13 && flashcards[rI].learned == 75) {
        add = true;
      }
      if (rD == 14 && flashcards[rI].learned == 100) {
        add = true;
      }
      if (add) {
        flashcardList.add(flashcards[rI]);
      }
    }
    return flashcardList;
  }
}

class FlashcardCard extends StatelessWidget {
  final String categoryId;
  final String deckId;
  final FlashcardModel flashcard;
  final bool flip;
  const FlashcardCard(
      {required this.categoryId,
      required this.deckId,
      required this.flashcard,
      required this.flip,
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
                    FlashcardsScreen(
                  categoryId: categoryId,
                  deckId: deckId,
                  flashcards: [flashcard],
                  studyMode: false,
                  flip: flip,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: getLearnedColor(flashcard.learned),
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(flip ? flashcard.backside : flashcard.frontside),
            ),
          ),
        ),
      ),
    );
  }
}

Color getLearnedColor(int? learned) {
  Color color;
  switch (learned) {
    case 25:
      color = const Color(0xFFFFD270);
      break;
    case 50:
      color = const Color(0xFFD9FF70);
      break;
    case 75:
      color = const Color(0xFF72FF70);
      break;
    case 100:
      color = const Color(0xFF70C8FF);
      break;
    default:
      color = const Color(0xFFFF7570);
      break;
  }
  return color;
}
