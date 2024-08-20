//view/player_turn_display.dart
import 'package:flutter/material.dart';

class PlayerTurnDisplay extends StatelessWidget {
  final String currentPlayer;
  final bool isSinglePlayer;

  const PlayerTurnDisplay({
    super.key,
    required this.currentPlayer,
    required this.isSinglePlayer,
  });

  @override
  Widget build(BuildContext context) {
    return isSinglePlayer
        ? const SizedBox.shrink()
        : Text(
            "Now $currentPlayer's Turn",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
  }
}
