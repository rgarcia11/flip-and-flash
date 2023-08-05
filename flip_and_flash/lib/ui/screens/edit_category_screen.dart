import 'package:flip_and_flash/core/models/category_model.dart';
import 'package:flip_and_flash/core/services/database.dart';
import 'package:flutter/material.dart';

const List<String> languagesList = <String>['English', 'Korean'];

// ignore: must_be_immutable
class EditCategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const EditCategoryScreen({required this.category, super.key});

  @override
  State<EditCategoryScreen> createState() => EditCategoryScreenState();
}

class EditCategoryScreenState extends State<EditCategoryScreen> {
  final DatabaseService _db = DatabaseService();

  final TextEditingController nameTextController = TextEditingController();
  String? editedCategoryFrontsideLanguage;
  String? editedCategoryBacksideLanguage;

  @override
  void initState() {
    super.initState();

    nameTextController.text = widget.category.name;
    editedCategoryFrontsideLanguage = widget.category.frontsideLanguage;
    editedCategoryBacksideLanguage = widget.category.backsideLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _db.editCategory(CategoryModel(
              id: widget.category.id,
              name: nameTextController.text,
              frontsideLanguage: editedCategoryFrontsideLanguage,
              backsideLanguage: editedCategoryBacksideLanguage,
            ));
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.check)),
      appBar: AppBar(
        title: const Text("Edit category"),
        actions: [
          IconButton(
            onPressed: () {
              _db.deleteCategory(widget.category.id!);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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
                  hintText: "Edit category name",
                  border: OutlineInputBorder(),
                ),
                controller: nameTextController,
                onChanged: (value) {
                  // setState(() {
                  //   nameTextController.text = value;
                  // });
                }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                    flex: 2, child: Text("Enter frontside language:")),
                Flexible(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: editedCategoryFrontsideLanguage,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    onChanged: (String? value) {
                      editedCategoryFrontsideLanguage = value!;
                      setState(() {
                        editedCategoryFrontsideLanguage;
                      });
                    },
                    items: languagesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                    flex: 2, child: Text("Enter backside language:")),
                Flexible(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: editedCategoryBacksideLanguage,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    onChanged: (String? value) {
                      editedCategoryBacksideLanguage = value!;
                      setState(() {
                        editedCategoryBacksideLanguage;
                      });
                    },
                    items: languagesList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
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
