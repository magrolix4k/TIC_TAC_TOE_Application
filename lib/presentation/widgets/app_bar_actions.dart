//view/app_bar_actions.dart

import 'package:flutter/material.dart';
import '../pages/game_history_page.dart';

class AppBarActions extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onReset;

  const AppBarActions({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.history),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GameHistoryScreen(),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Reset Game'),
                content: const Text('Are you sure you want to reset the game?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onReset();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
