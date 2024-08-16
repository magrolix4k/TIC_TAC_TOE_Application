import 'package:flutter/material.dart';
import '../viewmodels/replay_viewmodel.dart';

class ReplayScreen extends StatefulWidget {
  final List<String> moves;
  final int boardSize;

  ReplayScreen({required this.moves, required this.boardSize});

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
            child: Center(
              child: ValueListenableBuilder<int>(
                valueListenable: _counter,
                builder: (context, value, child) {
                  return Text(
                    '$value / ${widget.moves.length}',
                    style: const TextStyle(fontSize: 30),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: widget.boardSize,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                ),
                itemCount: widget.boardSize * widget.boardSize,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        _viewModel.board[index],
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_counter.value > 0) {
                        setState(() {
                          _counter.value--;
                          _viewModel.previousMove();
                        });
                      }
                    },
                    child: const Text('Previous'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _viewModel.resetBoard();
                        _counter.value = 0;
                      });
                    },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_counter.value <= widget.moves.length - 1) {
                        setState(() {
                          _counter.value++;
                          _viewModel.nextMove();
                        });
                      }
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
