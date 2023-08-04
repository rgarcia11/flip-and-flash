import 'package:flutter/material.dart';

class AddDeckDialog extends StatelessWidget {
  final void Function(String?) textFieldOnChanged;
  final void Function() submitDialog;

  const AddDeckDialog({
    required this.textFieldOnChanged,
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
              "Add deck",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
                decoration: const InputDecoration(
                  hintText: "Enter deck name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => textFieldOnChanged(value)),
            const SizedBox(height: 10),
            TextButton(
              onPressed: submitDialog,
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
