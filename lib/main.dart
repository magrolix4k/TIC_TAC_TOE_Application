//main.dart
import 'package:flutter/material.dart';
import 'presentation/bloc/tic_tac_toe_bloc.dart';
import 'presentation/pages/game_mode_selection_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TicTacToeViewModel _viewModel = TicTacToeViewModel();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameModeSelectionScreen(viewModel: _viewModel),
    );
  }
}
