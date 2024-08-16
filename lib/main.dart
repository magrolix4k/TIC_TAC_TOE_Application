import 'package:flutter/material.dart';
import 'viewmodels/tic_tac_toe_viewmodel.dart';
import 'views/mode_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TicTacToeViewModel _viewModel = TicTacToeViewModel();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameModeSelectionScreen(viewModel: _viewModel),
    );
  }
}
