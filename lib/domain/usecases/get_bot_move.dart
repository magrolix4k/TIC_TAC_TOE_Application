//viewmodels/bot_logic.dart
import 'dart:math';
import '../../core/enums/bot_difficulty.dart';

class BotLogic {
  final List<String> board;
  final String currentPlayer;
  final BotDifficulty botDifficulty;
  int boardSize;
  Random random = Random();

  BotLogic(this.board, this.currentPlayer, this.botDifficulty, this.boardSize);

  int getBestMove() {
    switch (botDifficulty) {
      case BotDifficulty.Easy:
        return getRandomMove();
      case BotDifficulty.Medium:
        return getMediumMove();
      case BotDifficulty.Hard:
        return getOptimalMove();
      default:
        return getRandomMove();
    }
  }

  int getRandomMove() {
    List<int> availableMoves = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        availableMoves.add(i);
      }
    }
    return availableMoves[random.nextInt(availableMoves.length)];
  }

  int getMediumMove() {
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'X';
        if (checkWinner('X')) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }
    return getRandomMove();
  }

  int getOptimalMove() {
    const int maxDepth = 6;
    return minimax(board, currentPlayer, -1000, 1000, 0, maxDepth)['index']!;
  }

  Map<String, dynamic> minimax(List<String> board, String player, int alpha,
      int beta, int depth, int maxDepth) {
    String opponent = player == 'X' ? 'O' : 'X';

    if (depth >= maxDepth) return {'score': 0};
    if (checkWinner('X')) return {'score': -10};
    if (checkWinner('O')) return {'score': 10};
    if (!board.contains('')) return {'score': 0};

    List<int> emptySpaces = [];
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        emptySpaces.add(i);
      }
    }

    int bestScore = player == 'O' ? -1000 : 1000;
    int bestMove = -1;

    for (int i in emptySpaces) {
      board[i] = player;
      Map<String, dynamic> result =
          minimax(board, opponent, alpha, beta, depth + 1, maxDepth);
      board[i] = '';

      int score = result['score']!;
      if (player == 'O') {
        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
        alpha = max(alpha, bestScore);
      } else {
        if (score < bestScore) {
          bestScore = score;
          bestMove = i;
        }
        beta = min(beta, bestScore);
      }

      if (beta <= alpha) {
        break;
      }
    }

    return {'index': bestMove, 'score': bestScore};
  }

  bool checkWinner(String player) {
    // Check rows
    for (int i = 0; i < boardSize; i++) {
      if (board
          .sublist(i * boardSize, (i + 1) * boardSize)
          .every((element) => element == player)) {
        return true;
      }
    }
    // Check columns
    for (int i = 0; i < boardSize; i++) {
      if (List.generate(boardSize, (j) => board[i + j * boardSize])
          .every((element) => element == player)) {
        return true;
      }
    }
    // Check diagonals
    if (List.generate(boardSize, (i) => board[i * boardSize + i])
        .every((element) => element == player)) {
      return true;
    }
    if (List.generate(boardSize, (i) => board[(i + 1) * boardSize - (i + 1)])
        .every((element) => element == player)) {
      return true;
    }
    return false;
  }
}
