//view/game_mode_buttons.dart

import 'package:flutter/material.dart';

class GameModeButtons extends StatelessWidget {
  final bool isSinglePlayer;
  final ValueChanged<bool> onModeChanged;

  const GameModeButtons({
    super.key,
    required this.isSinglePlayer,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => onModeChanged(true),
          child: const Text('Single Player'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => onModeChanged(false),
          child: const Text('Two Player'),
        ),
      ],
    );
  }
}
