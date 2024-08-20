//viewmodels/tic_tac_toe_viewmodel.dart
import 'package:flutter/material.dart';
import '../../core/enums/bot_difficulty.dart';
import '../../data/datasources/local/database_helper.dart';
import '../../domain/usecases/get_bot_move.dart';

class TicTacToeViewModel extends ChangeNotifier {
  int boardSize = 3;
  List<String> board = [];
  String currentPlayer = 'X';
  bool gameEnded = false;
  String winner = '';
  bool isSinglePlayer = true;
  BotDifficulty botDifficulty = BotDifficulty.Easy;
  List<String> moves = [];

  TicTacToeViewModel();

  void resetGame() {
    board = List.filled(boardSize * boardSize, '');
    currentPlayer = 'X';
    gameEnded = false;
    winner = '';
    moves.clear();
    notifyListeners();
  }

  void setGameMode(bool singlePlayer) {
    isSinglePlayer = singlePlayer;
    resetGame();
  }

  void setBotDifficulty(BotDifficulty difficulty) {
    botDifficulty = difficulty;
    resetGame();
  }

  void setBoardSize(int size) {
    boardSize = size;
    resetGame();
  }

  void makeMove(int index) {
    if (board[index] == '' && !gameEnded) {
      board[index] = currentPlayer;
      moves.add('$index:$currentPlayer');

      if (checkWinner(currentPlayer)) {
        gameEnded = true;
        winner = currentPlayer;
        saveGameRecord();
      } else if (!board.contains('')) {
        gameEnded = true;
        winner = 'Draw';
        saveGameRecord();
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        if (isSinglePlayer && currentPlayer == 'O') {
          BotLogic botLogic =
              BotLogic(board, currentPlayer, botDifficulty, boardSize);
          int index = botLogic.getBestMove();
          makeMove(index);
        }
      }
      notifyListeners();
    }
  }

  bool checkWinner(String player) {
    for (int i = 0; i < boardSize; i++) {
      if (board
          .sublist(i * boardSize, (i + 1) * boardSize)
          .every((element) => element == player)) {
        return true;
      }
    }
    for (int i = 0; i < boardSize; i++) {
      if (List.generate(boardSize, (j) => board[i + j * boardSize])
          .every((element) => element == player)) {
        return true;
      }
    }
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

  void saveGameRecord() async {
    await DatabaseHelper.instance.saveGame(
      boardSize: boardSize,
      winner: winner,
      isSinglePlayer: isSinglePlayer,
      botDifficulty: botDifficulty,
      moves: moves,
    );
  }
}
