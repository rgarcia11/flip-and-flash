import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateFlashcardScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;
  final bool edit;
  FlashcardModel? flashcard;

  CreateFlashcardScreen(
      {required this.categoryId,
      required this.deckId,
      this.edit = false,
      this.flashcard,
      super.key})
      : assert((edit && flashcard != null) || (!edit && flashcard == null), """
            If edit mode is true, you have to provide a flashcard model. 
            If edit mode is false, you shouldn't provide a flashcard model.""");

  @override
  State<CreateFlashcardScreen> createState() => _CreateFlashcardScreenState();
}

class _CreateFlashcardScreenState extends State<CreateFlashcardScreen> {
  final DatabaseService _db = DatabaseService();

  String? frontsideValue;
  String? backsideValue;

  final TextEditingController frontsideTextController = TextEditingController();
  final TextEditingController backsideTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    frontsideValue = widget.edit ? widget.flashcard!.frontside : "";
    backsideValue = widget.edit ? widget.flashcard!.backside : "";
    frontsideTextController.text =
        widget.edit ? widget.flashcard!.frontside : "";
    backsideTextController.text = widget.edit ? widget.flashcard!.backside : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (widget.edit) {
              _db.editFlashcard(
                widget.categoryId,
                widget.deckId,
                widget.flashcard!.id!,
                FlashcardModel(
                    frontside: frontsideValue!, backside: backsideValue!),
              );
              Navigator.of(context).pop();
            } else {
              _db.createFlashcard(
                  widget.categoryId,
                  widget.deckId,
                  FlashcardModel(
                    frontside: frontsideValue!,
                    backside: backsideValue!,
                  ));
              Navigator.of(context).pop();
            }
          },
          child: Icon(widget.edit ? Icons.check : Icons.add)),
      appBar:
          AppBar(title: Text(widget.edit ? "Edit flashcard" : "New flashcard")),
      body: Column(
        children: [
          FlashcardSideCard(
            text: "Enter backside word or value",
            textController: frontsideTextController,
            onChanged: (value) {
              setState(() {
                frontsideValue = value;
              });
            },
          ),
          FlashcardSideCard(
            text: "Enter backside word or value",
            textController: backsideTextController,
            onChanged: (value) {
              setState(() {
                backsideValue = value;
              });
            },
          ),
        ],
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
