import 'package:flip_and_flash/core/models/flashcard_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateEditFlashcardScreen extends StatefulWidget {
  final String categoryId;
  final String deckId;
  final bool edit;
  FlashcardModel? flashcard;

  CreateEditFlashcardScreen(
      {required this.categoryId,
      required this.deckId,
      this.edit = false,
      this.flashcard,
      super.key})
      : assert((edit && flashcard != null) || (!edit && flashcard == null), """
            If edit mode is true, you have to provide a flashcard model. 
            If edit mode is false, you shouldn't provide a flashcard model.""");

  @override
  State<CreateEditFlashcardScreen> createState() =>
      _CreateEditFlashcardScreenState();
}

class _CreateEditFlashcardScreenState extends State<CreateEditFlashcardScreen> {
  final DatabaseService _db = DatabaseService();

  late String frontsideValue;
  late String backsideValue;

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
          onPressed: () async {
            if (widget.edit) {
              await _db.editFlashcard(
                widget.categoryId,
                widget.deckId,
                widget.flashcard!.id!,
                FlashcardModel(
                  frontside: frontsideValue,
                  backside: backsideValue,
                  learned: widget.flashcard!.learned,
                ),
              );
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            } else {
              await _db.createFlashcard(
                  widget.categoryId,
                  widget.deckId,
                  FlashcardModel(
                    frontside: frontsideValue,
                    backside: backsideValue,
                    learned: 0,
                  ));
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: Icon(widget.edit ? Icons.check : Icons.add)),
      appBar: AppBar(
        title: Text(widget.edit ? "Edit flashcard" : "New flashcard"),
        actions: widget.edit
            ? [
                IconButton(
                  onPressed: () {
                    _db.deleteFlashcard(widget.categoryId, widget.deckId,
                        widget.flashcard!.id!);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete),
                ),
              ]
            : [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlashcardSideCard(
              text: "Enter frontside word or value",
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
