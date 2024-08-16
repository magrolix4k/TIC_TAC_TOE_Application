import 'package:flutter/material.dart';

import '../models/game_model.dart';
import '../viewmodels/tic_tac_toe_viewmodel.dart';
import 'game_history_screen.dart';
import 'tic_tac_toe_screen.dart';

class GameModeSelectionScreen extends StatefulWidget {
  final TicTacToeViewModel viewModel;
  const GameModeSelectionScreen({super.key, required this.viewModel});

  @override
  State<GameModeSelectionScreen> createState() =>
      _GameModeSelectionScreenState();
}

class _GameModeSelectionScreenState extends State<GameModeSelectionScreen> {
  late bool isSinglePlayer;
  late BotDifficulty botDifficulty;
  late int boardSize;

  @override
  void initState() {
    super.initState();
    isSinglePlayer = widget.viewModel.isSinglePlayer;
    botDifficulty = widget.viewModel.botDifficulty;
    boardSize = widget.viewModel.boardSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Column(
            children: [
              Text(
                "Game Mode Selection",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSinglePlayer = true;
                  });
                },
                child: const Text('Single Player'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isSinglePlayer = false;
                  });
                },
                child: const Text('Two Player'),
              ),
            ],
          ),
          if (isSinglePlayer)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Difficulty: '),
                DropdownButton<BotDifficulty>(
                  value: botDifficulty,
                  onChanged: (BotDifficulty? newDifficulty) {
                    if (newDifficulty != null) {
                      setState(() {
                        botDifficulty = newDifficulty;
                      });
                    }
                  },
                  items: BotDifficulty.values.map((BotDifficulty difficulty) {
                    return DropdownMenuItem<BotDifficulty>(
                      value: difficulty,
                      child: Text(difficulty.name),
                    );
                  }).toList(),
                ),
              ],
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Board Size: '),
              DropdownButton<int>(
                value: boardSize,
                onChanged: (int? newSize) {
                  if (newSize != null) {
                    setState(() {
                      boardSize = newSize;
                    });
                  }
                },
                items: [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
                    .map<DropdownMenuItem<int>>((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              setState(
                () {
                  widget.viewModel.setGameMode(isSinglePlayer);
                  widget.viewModel.setBotDifficulty(botDifficulty);
                  widget.viewModel.setBoardSize(boardSize);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          TicTacToeScreen(viewModel: widget.viewModel),
                    ),
                  );
                },
              );
            },
            child: const Text('Start Game'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameHistoryScreen(),
                ),
              );
            },
            child: const Text('History Game'),
          )
        ],
      ),
    );
  }
}
