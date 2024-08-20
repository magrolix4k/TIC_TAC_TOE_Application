//view/game_result_display.dart
import 'package:flutter/material.dart';

class GameResultDisplay extends StatelessWidget {
  final String winner;
  final bool isSinglePlayer;

  const GameResultDisplay({
    super.key,
    required this.winner,
    required this.isSinglePlayer,
  });

  @override
  Widget build(BuildContext context) {
    if (winner.isEmpty) return const SizedBox.shrink();
    final resultText = isSinglePlayer
        ? winner == 'Draw'
            ? 'Game Draw'
            : winner == 'X'
                ? 'You win!!!'
                : 'You lose!'
        : winner == 'Draw'
            ? 'Game Draw'
            : 'Player $winner wins!';

    return Text(
      resultText,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
