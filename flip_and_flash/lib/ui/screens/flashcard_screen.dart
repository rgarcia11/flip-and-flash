import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/material.dart';

class FlashcardScreen extends StatefulWidget {
  final FlashcardModel? flashcard;
  const FlashcardScreen({this.flashcard, super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Flashcard')),
        body: Column(
          children: [
            FlashcardSideCard(
              side: widget.flashcard!.frontside,
            ),
            FlashcardSideCard(
              side: widget.flashcard!.backside,
            ),
          ],
        ));
  }
}

class FlashcardSideCard extends StatelessWidget {
  final String? side;
  const FlashcardSideCard({this.side, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            // TODO: make it editable
            print('GATOOO');
            DatabaseService db = DatabaseService();
            db.testAdd();
            db.testRead();
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(side != null ? side! : ''),
            ),
          ),
        ),
      ),
    );
  }
}
