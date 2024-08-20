//view/game_mode_selection_screen.dart
import 'package:flutter/material.dart';
import '../../core/enums/bot_difficulty.dart';
import '../bloc/tic_tac_toe_bloc.dart';
import 'game_history_page.dart';
import 'tic_tac_toe_page.dart';
import '../widgets/game_mode_buttons.dart';
import '../widgets/bot_difficulty_selector.dart';
import '../widgets/board_size_slider.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Game Mode Selection",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 80),
          GameModeButtons(
            isSinglePlayer: isSinglePlayer,
            onModeChanged: (mode) {
              setState(() {
                isSinglePlayer = mode;
              });
            },
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          if (isSinglePlayer)
            BotDifficultySelector(
              botDifficulty: botDifficulty,
              onDifficultyChanged: (difficulty) {
                setState(() {
                  botDifficulty = difficulty;
                });
              },
            ),
          if (isSinglePlayer) const Divider(),
          const SizedBox(height: 10),
          BoardSizeSlider(
            boardSize: boardSize,
            onSizeChanged: (newSize) {
              setState(() {
                boardSize = newSize;
              });
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
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
            child: const Text('Start Game'),
          ),
          const SizedBox(height: 20),
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
