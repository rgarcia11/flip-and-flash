import 'package:flutter/material.dart';

class AddCategoryDialog extends StatelessWidget {
  final String newCategoryFrontsideLanguage;
  final String newCategoryBacksideLanguage;
  final List<String> languagesList;
  final void Function(String?) textFieldOnChanged;
  final void Function(String?) frontsideLanguageOnChanged;
  final void Function(String?) backsideLanguageOnChanged;
  final void Function() submitDialog;

  const AddCategoryDialog({
    required this.newCategoryFrontsideLanguage,
    required this.newCategoryBacksideLanguage,
    required this.languagesList,
    required this.textFieldOnChanged,
    required this.frontsideLanguageOnChanged,
    required this.backsideLanguageOnChanged,
    required this.submitDialog,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add category",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Enter category name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => textFieldOnChanged(value)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                    flex: 2, child: Text("Enter frontside language:")),
                Flexible(
                  flex: 1,
                  child: DropdownButtonFormField<String>(
                    value: newCategoryFrontsideLanguage,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    onChanged: frontsideLanguageOnChanged,
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
                    value: newCategoryBacksideLanguage,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    onChanged: backsideLanguageOnChanged,
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
            TextButton(
              onPressed: submitDialog,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
