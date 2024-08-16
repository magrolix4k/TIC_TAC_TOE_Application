//databasse_helper.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/game_model.dart';

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
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE games (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      boardSize INTEGER,
      winner TEXT,
      isSinglePlayer INTEGER,
      botDifficulty TEXT,
      moves TEXT,
      dateTime TEXT
    )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      ALTER TABLE games ADD COLUMN botDifficulty TEXT;
      ALTER TABLE games ADD COLUMN dateTime TEXT;
      ''');
    }
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

  // Delete a specific game by ID
  Future<void> deleteGameById(int id) async {
    final db = await instance.database;
    await db.delete('games', where: 'id = ?', whereArgs: [id]);
  }

  // Delete all games
  Future<void> deleteAllGames() async {
    final db = await instance.database;
    await db.delete('games');
  }
}
