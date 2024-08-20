//viewmodels/replay_viewmodel.dart
class ReplayViewModel {
  final List<String> moves;
  final int boardSize;
  List<String> board;
  int currentMoveIndex;

  ReplayViewModel(this.moves, this.boardSize)
      : board = List.filled(boardSize * boardSize, ''),
        currentMoveIndex = -1;

  void resetBoard() {
    board = List.filled(boardSize * boardSize, '');
    currentMoveIndex = -1;
  }

  void nextMove() {
    if (currentMoveIndex < moves.length - 1) {
      currentMoveIndex++;
      final move = moves[currentMoveIndex].split(':');
      if (move.length == 2) {
        try {
          final index = int.parse(move[0]);
          if (index >= 0 && index < board.length) {
            final player = move[1];
            board[index] = player;
          }
        } catch (e) {
          // Handle parse error
          print('Error parsing move: $e');
        }
      }
    }
  }

  void previousMove() {
    if (currentMoveIndex >= 0) {
      final move = moves[currentMoveIndex].split(':');
      if (move.length == 2) {
        try {
          final index = int.parse(move[0]);
          if (index >= 0 && index < board.length) {
            board[index] = '';
            currentMoveIndex--;
          }
        } catch (e) {
          // Handle parse error
          print('Error parsing move: $e');
        }
      }
    }
  }
}
