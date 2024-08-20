//view/delete_all_dialog.dart
import 'package:flutter/material.dart';

class DeleteAllDialog extends StatelessWidget {
  final Future<void> Function() onConfirm;

  const DeleteAllDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure you want to delete all game history?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            onConfirm();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
