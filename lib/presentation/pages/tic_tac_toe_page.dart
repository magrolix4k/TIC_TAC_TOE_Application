//view/tic_tac_toe_screen.dart

import 'package:flutter/material.dart';
import '../bloc/tic_tac_toe_bloc.dart';
import '../widgets/app_bar_actions.dart';
import '../widgets/player_turn_display.dart';
import '../widgets/game_board.dart';
import '../widgets/game_result_display.dart';

class TicTacToeScreen extends StatefulWidget {
  final TicTacToeViewModel viewModel;

  const TicTacToeScreen({super.key, required this.viewModel});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late TicTacToeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.viewModel;
    _viewModel.resetGame();
  }

  void _resetGame() {
    setState(() {
      _viewModel.resetGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          AppBarActions(onReset: _resetGame),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: PlayerTurnDisplay(
                currentPlayer: _viewModel.currentPlayer,
                isSinglePlayer: _viewModel.isSinglePlayer,
              ),
            ),
            Expanded(
              flex: 3,
              child: GameBoard(
                boardSize: _viewModel.boardSize,
                board: _viewModel.board,
                onTap: (index) {
                  setState(() {
                    _viewModel.makeMove(index);
                  });
                },
              ),
            ),
            Expanded(
              child: GameResultDisplay(
                winner: _viewModel.winner,
                isSinglePlayer: _viewModel.isSinglePlayer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
