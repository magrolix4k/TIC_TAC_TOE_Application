class ReplayViewModel {
  final List<String> moves;
  final int boardSize;
  List<String> board = [];
  int currentMoveIndex = -1;

  ReplayViewModel(this.moves, this.boardSize) {
    resetBoard();
  }

  void resetBoard() {
    board = List.filled(boardSize * boardSize, '');
    currentMoveIndex = -1;
  }

  void nextMove() {
    if (currentMoveIndex < moves.length - 1) {
      currentMoveIndex++;
      final move = moves[currentMoveIndex].split(':');
      final index = int.parse(move[0]);
      final player = move[1];
      board[index] = player;
    }
  }

  void previousMove() {
    if (currentMoveIndex >= 0) {
      final move = moves[currentMoveIndex].split(':');
      final index = int.parse(move[0]);
      board[index] = '';
      currentMoveIndex--;
    }
  }
}
