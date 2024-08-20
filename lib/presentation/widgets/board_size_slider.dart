//view/board_size_slider.dart
import 'package:flutter/material.dart';

class BoardSizeSlider extends StatelessWidget {
  final int boardSize;
  final ValueChanged<int> onSizeChanged;

  const BoardSizeSlider({
    super.key,
    required this.boardSize,
    required this.onSizeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Board Size: '),
        Slider(
          value: boardSize.toDouble(),
          min: 3,
          max: 15,
          divisions: 12,
          label: "${boardSize.toString()}x${boardSize.toString()}",
          onChanged: (newSize) {
            onSizeChanged(newSize.toInt());
          },
        ),
      ],
    );
  }
}
