//view/control_buttons.dart
import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  final VoidCallback onPrevious;
  final VoidCallback onReset;
  final VoidCallback onNext;

  const ControlButtons({
    super.key,
    required this.onPrevious,
    required this.onReset,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: onPrevious,
          child: const Text('Previous'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onReset,
          child: const Text('Reset'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: onNext,
          child: const Text('Next'),
        ),
      ],
    );
  }
}
