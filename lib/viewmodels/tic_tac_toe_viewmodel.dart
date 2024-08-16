import 'dart:math';
import '../models/game_model.dart';
import '../services/database_helper.dart';

class TicTacToeViewModel {
  int boardSize = 3;
  List<String> board = [];
  String currentPlayer = 'X';
  bool gameEnded = false;
  String winner = '';
  bool isSinglePlayer = true;
  Random random = Random();
  List<String> moves = [];
  BotDifficulty botDifficulty = BotDifficulty.Easy;

  void resetGame() {
    board = List.filled(boardSize * boardSize, '');
    currentPlayer = 'X';
    gameEnded = false;
    winner = '';
    moves.clear();
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
          makeBotMove();
        }
      }
    }
  }

  void makeBotMove() {
    int index;
    switch (botDifficulty) {
      case BotDifficulty.Easy:
        index = getRandomMove();
        break;
      case BotDifficulty.Medium:
        index = getMediumMove();
        break;
      case BotDifficulty.Hard:
        index = getBestMove();
        break;
    }
    makeMove(index);
  }

  int getRandomMove() {
    int index = random.nextInt(boardSize * boardSize);
    while (board[index] != '') {
      index = random.nextInt(boardSize * boardSize);
    }
    return index;
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

  int getBestMove() {
    return minimax(board, currentPlayer)['index'];
  }

  Map<String, dynamic> minimax(List<String> board, String player) {
    String opponent = player == 'X' ? 'O' : 'X';
    List<Map<String, dynamic>> emptySpaces = [];

    if (checkWinner('X')) return {'score': -10};
    if (checkWinner('O')) return {'score': 10};
    if (!board.contains('')) return {'score': 0};

    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = player;
        Map<String, dynamic> result = minimax(board, opponent);
        board[i] = '';
        emptySpaces.add({'index': i, 'score': result['score']});
      }
    }

    if (player == 'O') {
      int bestScore = -1000;
      int bestMove = -1;
      for (var move in emptySpaces) {
        if (move['score'] > bestScore) {
          bestScore = move['score'];
          bestMove = move['index'];
        }
      }
      return {'index': bestMove, 'score': bestScore};
    } else {
      int bestScore = 1000;
      int bestMove = -1;
      for (var move in emptySpaces) {
        if (move['score'] < bestScore) {
          bestScore = move['score'];
          bestMove = move['index'];
        }
      }
      return {'index': bestMove, 'score': bestScore};
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
      bool columnWin = true;
      for (int j = 0; j < boardSize; j++) {
        if (board[i + j * boardSize] != player) {
          columnWin = false;
          break;
        }
      }
      if (columnWin) return true;
    }
    bool diagonal1 = true;
    bool diagonal2 = true;
    for (int i = 0; i < boardSize; i++) {
      if (board[i * boardSize + i] != player) {
        diagonal1 = false;
      }
      if (board[(i + 1) * boardSize - (i + 1)] != player) {
        diagonal2 = false;
      }
    }
    if (diagonal1 || diagonal2) return true;

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
