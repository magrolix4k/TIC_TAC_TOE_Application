enum BotDifficulty { Easy, Medium, Hard }

class GameModel {
  final int boardSize;
  final String winner;
  final bool isSinglePlayer;
  final BotDifficulty botDifficulty;
  final List<String> moves;
  final String dateTime;

  GameModel({
    required this.boardSize,
    required this.winner,
    required this.isSinglePlayer,
    required this.botDifficulty,
    required this.moves,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'boardSize': boardSize,
      'winner': winner,
      'isSinglePlayer': isSinglePlayer ? 1 : 0,
      'botDifficulty': botDifficulty.name,
      'moves': moves.join(','),
      'dateTime': dateTime,
    };
  }

  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      boardSize: map['boardSize'],
      winner: map['winner'],
      isSinglePlayer: map['isSinglePlayer'] == 1,
      botDifficulty: BotDifficulty.values
          .firstWhere((e) => e.name == map['botDifficulty']),
      moves: map['moves'].toString().split(','),
      dateTime: map['dateTime'],
    );
  }
}
