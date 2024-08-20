//view/game_board.dart
import 'package:flutter/material.dart';

class GameBoard extends StatelessWidget {
  final int boardSize;
  final List<String> board;
  final ValueChanged<int> onTap;

  const GameBoard({
    super.key,
    required this.boardSize,
    required this.board,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: boardSize,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
        ),
        itemCount: boardSize * boardSize,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  board[index],
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
