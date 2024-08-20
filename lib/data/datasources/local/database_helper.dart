//services/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../core/enums/bot_difficulty.dart';
import '../../../core/constants/database_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tic_tac_toe.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(createGamesTable);
  }

  Future<void> saveGame({
    required int boardSize,
    required String winner,
    required bool isSinglePlayer,
    required BotDifficulty botDifficulty,
    required List<String> moves,
  }) async {
    final db = await instance.database;
    await db.insert('games', {
      'boardSize': boardSize,
      'winner': winner,
      'isSinglePlayer': isSinglePlayer ? 1 : 0,
      'botDifficulty': botDifficulty.name,
      'moves': moves.join(','),
      'dateTime': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getGames() async {
    final db = await instance.database;
    return await db.query('games', orderBy: 'dateTime DESC');
  }

  Future<void> deleteGameById(int id) async {
    final db = await instance.database;
    await db.delete('games', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllGames() async {
    final db = await instance.database;
    await db.delete('games');
  }
}
