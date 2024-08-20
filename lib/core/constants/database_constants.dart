//services/database_schemas.dart
const String createGamesTable = '''
CREATE TABLE games (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  boardSize INTEGER,
  winner TEXT,
  isSinglePlayer INTEGER,
  botDifficulty TEXT,
  moves TEXT,
  dateTime TEXT
)
''';
