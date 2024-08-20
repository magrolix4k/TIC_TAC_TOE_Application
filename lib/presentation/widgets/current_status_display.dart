//view/current_status_display.dart
import 'package:flutter/material.dart';

class CurrentStatusDisplay extends StatelessWidget {
  final int currentMove;
  final int totalMoves;

  const CurrentStatusDisplay({
    super.key,
    required this.currentMove,
    required this.totalMoves,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$currentMove / $totalMoves',
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}
