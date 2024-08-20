//viewmodels/game_history_viewmodel.dart
import '../../data/datasources/local/database_helper.dart';

class GameHistoryViewModel {
  Future<List<Map<String, dynamic>>> getGames() async {
    return await DatabaseHelper.instance.getGames();
  }
}
