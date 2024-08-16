import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../viewmodels/game_history_viewmodel.dart';
import '../services/database_helper.dart';
import 'replay_screen.dart';

class GameHistoryScreen extends StatefulWidget {
  const GameHistoryScreen({super.key});

  @override
  _GameHistoryScreenState createState() => _GameHistoryScreenState();
}

class _GameHistoryScreenState extends State<GameHistoryScreen> {
  late Future<List<Map<String, dynamic>>> _gamesFuture;

  @override
  void initState() {
    super.initState();
    _gamesFuture = _viewModel.getGames();
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
                builder: (context) => AlertDialog(
                  title: const Text('Confirm Delete'),
                  content: const Text(
                      'Are you sure you want to delete all game history?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await DatabaseHelper.instance.deleteAllGames();
                setState(() {
                  _gamesFuture = _viewModel.getGames();
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _gamesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final games = snapshot.data!;
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              final game = games[index];
              final moves = game['moves'].toString().split(',');

              final DateTime dateTime = DateTime.parse(game['dateTime']);
              final formattedDateTime =
                  DateFormat('dd MMM yyyy, HH:mm').format(dateTime);

              return Column(
                children: [
                  ListTile(
                    title: Text(
                        'Winner: ${game['winner']}, Board Size: ${game['boardSize']}'),
                    subtitle: Text(
                        'Mode: ${game['isSinglePlayer'] == 1 ? 'Single Player' : 'Two Player'}, Difficulty: ${game['botDifficulty']}, \nDate: $formattedDateTime'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.play_arrow),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReplayScreen(
                                  moves: moves,
                                  boardSize: game['boardSize'],
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirm Delete'),
                                content: const Text(
                                    'Are you sure you want to delete this game history?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await DatabaseHelper.instance
                                  .deleteGameById(game['id']);
                              setState(() {
                                _gamesFuture = _viewModel.getGames();
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
