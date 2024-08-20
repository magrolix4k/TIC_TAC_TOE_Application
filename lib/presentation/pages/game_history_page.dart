//view/game_history_screen.dart
import 'package:flutter/material.dart';
import '../bloc/game_history_bloc.dart';
import '../../data/datasources/local/database_helper.dart';
import '../widgets/game_list_tile.dart';
import '../widgets/delete_all_dialog.dart';

class GameHistoryScreen extends StatefulWidget {
  const GameHistoryScreen({super.key});

  @override
  _GameHistoryScreenState createState() => _GameHistoryScreenState();
}

class _GameHistoryScreenState extends State<GameHistoryScreen> {
  late Future<List<Map<String, dynamic>>> _gamesdata;

  @override
  void initState() {
    super.initState();
    _gamesdata = _viewModel.getGames();
  }

  final GameHistoryViewModel _viewModel = GameHistoryViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => DeleteAllDialog(
                  onConfirm: () async {
                    await DatabaseHelper.instance.deleteAllGames();
                    setState(() {
                      _gamesdata = _viewModel.getGames();
                    });
                  },
                ),
              );

              if (confirm != true) return;
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _gamesdata,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final games = snapshot.data!;
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              return GameListTile(
                game: game,
                onDelete: (id) async {
                  await DatabaseHelper.instance.deleteGameById(id);
                  setState(() {
                    _gamesdata = _viewModel.getGames();
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
