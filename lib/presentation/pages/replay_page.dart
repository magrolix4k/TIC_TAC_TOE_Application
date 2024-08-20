//view/replay_screen.dart

import 'package:flutter/material.dart';
import '../bloc/replay_bloc.dart';
import '../widgets/current_status_display.dart';
import '../widgets/game_board.dart';
import '../widgets/control_buttons.dart';

class ReplayScreen extends StatefulWidget {
  final List<String> moves;
  final int boardSize;

  const ReplayScreen({super.key, required this.moves, required this.boardSize});

  @override
  _ReplayScreenState createState() => _ReplayScreenState();
}

class _ReplayScreenState extends State<ReplayScreen> {
  late ReplayViewModel _viewModel;
  late ValueNotifier<int> _counter;

  @override
  void initState() {
    super.initState();
    _viewModel = ReplayViewModel(widget.moves, widget.boardSize);
    _counter = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  void _previousMove() {
    if (_counter.value > 0) {
      setState(() {
        _counter.value--;
        _viewModel.previousMove();
      });
    }
  }

  void _resetBoard() {
    setState(() {
      _viewModel.resetBoard();
      _counter.value = 0;
    });
  }

  void _nextMove() {
    if (_counter.value < widget.moves.length - 1) {
      setState(() {
        _counter.value++;
        _viewModel.nextMove();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Replay Game'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: CurrentStatusDisplay(
              currentMove: _counter.value,
              totalMoves: widget.moves.length,
            ),
          ),
          Expanded(
            flex: 3,
            child: GameBoard(
              boardSize: widget.boardSize,
              board: _viewModel.board,
              onTap: (index) {}, // Handle board tap if needed
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: ControlButtons(
                onPrevious: _previousMove,
                onReset: _resetBoard,
                onNext: _nextMove,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
