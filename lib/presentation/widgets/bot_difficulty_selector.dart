//view/bot_difficulty_selector.dart
import 'package:flutter/material.dart';
import '../../core/enums/bot_difficulty.dart';

class BotDifficultySelector extends StatelessWidget {
  final BotDifficulty botDifficulty;
  final ValueChanged<BotDifficulty> onDifficultyChanged;

  const BotDifficultySelector({
    super.key,
    required this.botDifficulty,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Difficulty: '),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: BotDifficulty.values.map((difficulty) {
            return Row(
              children: [
                Radio<BotDifficulty>(
                  value: difficulty,
                  groupValue: botDifficulty,
                  onChanged: (newDifficulty) {
                    if (newDifficulty != null) {
                      onDifficultyChanged(newDifficulty);
                    }
                  },
                ),
                Text(difficulty.name),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
