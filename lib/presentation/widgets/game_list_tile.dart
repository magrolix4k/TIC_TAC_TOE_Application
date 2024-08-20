//view/game_list_tile.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/replay_page.dart';

class GameListTile extends StatelessWidget {
  final Map<String, dynamic> game;
  final Function(int) onDelete;

  const GameListTile({
    super.key,
    required this.game,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final moves = game['moves'].toString().split(',');

    final DateTime dateTime = DateTime.parse(game['dateTime']);
    final formattedDateTime = DateFormat('dd MMM yyyy, HH:mm').format(dateTime);

    return Column(
      children: [
        ListTile(
          title: Text(
              'Winner: ${game['winner']}, Board Size: ${game['boardSize']}'),
          subtitle: Text(
              'Mode: ${game['isSinglePlayer'] == 1 ? 'Single Player,' : 'Two Player'} ${game['isSinglePlayer'] == 0 ? '' : 'Difficulty: ${game['botDifficulty']}'} \nDate: $formattedDateTime'),
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
                    onDelete(game['id']);
                  }
                },
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
