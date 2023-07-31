import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final List<DeckModel>? decks;
  const CategoryScreen({this.decks, super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Decks')),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount),
          itemBuilder: (BuildContext context, index) {
            return widget.decks != null
                ? DeckCard(
                    deck: widget.decks![index],
                  )
                : const DeckCard();
          },
          itemCount: widget.decks != null ? widget.decks!.length : 0),
    );
  }
}

class DeckCard extends StatelessWidget {
  final DeckModel? deck;
  const DeckCard({this.deck, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DeckScreen(
                  cards: deck!.cards,
                ),
              ),
            );
          },
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(deck != null ? deck!.name : ''),
            ),
          ),
        ),
      ),
    );
  }
}
