import 'package:flip_and_flash/core/models/deck_model.dart';
import 'package:flip_and_flash/core/providers/deck_provider.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<String> languagesList = <String>['English', 'Korean'];

// ignore: must_be_immutable
class EditDeckScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;

  const EditDeckScreen(
      {required this.categoryId, required this.deckId, super.key});

  @override
  State<EditDeckScreen> createState() => EditDeckScreenState();
}

class EditDeckScreenState extends State<EditDeckScreen> {
  final DatabaseService _db = DatabaseService();

  final TextEditingController nameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameTextController.text =
        context.read<DeckProvider>().decksById[widget.deckId]!.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _db.editDeck(
                widget.categoryId,
                DeckModel(
                  id: widget.deckId,
                  name: nameTextController.text,
                ));
            Navigator.of(context).pop();
            // TODO: Needs to pop until category screen
          },
          child: const Icon(Icons.check)),
      appBar: AppBar(
        title: const Text("Edit deck"),
        actions: [
          IconButton(
            onPressed: () {
              _db.deleteDeck(widget.categoryId, widget.deckId);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              // TODO: We need a better routing system
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Edit deck name",
                border: OutlineInputBorder(),
              ),
              controller: nameTextController,
              onChanged: (value) {
                // setState(() {
                //   nameTextController.text = value;
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FlashcardSideCard extends StatelessWidget {
  final String text;
  final void Function(String) onChanged;
  final TextEditingController textController;
  const FlashcardSideCard(
      {required this.text,
      required this.textController,
      required this.onChanged,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: 300,
          height: 300,
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: text,
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
