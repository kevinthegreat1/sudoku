import 'package:flutter/material.dart';

import 'solve.dart';

void main() {
  runApp(const SudokuApp());
}

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sudoku',
      home: Sudoku(),
    );
  }
}

class Sudoku extends StatefulWidget {
  const Sudoku({super.key});

  @override
  State<Sudoku> createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  final List<TextEditingController> _board = List.generate(81, (index) {
    return TextEditingController();
  });
  List<String>? _savedBoard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Flexible(
          child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(9, (index) {
                return SudokuTile(index: index, controllers: _board);
              }),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                child: const Text('Solve 1'),
                onPressed: () {
                  solve1(_board);
                }),
            ElevatedButton(
                child: const Text('Solve 2'),
                onPressed: () {
                  solve2(_board);
                }),
            ElevatedButton(
                child: const Text('Solve 3'),
                onPressed: () {
                  solve3(_board);
                }),
            ElevatedButton(
                child: const Text('Solve 4'),
                onPressed: () {
                  solve4(_board);
                }),
            ElevatedButton(
                child: const Text('Solve 5'),
                onPressed: () {
                  solve5(_board);
                }),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  _savedBoard = _board.map((e) => e.text).toList();
                }),
            ElevatedButton(
                child: const Text('Load'),
                onPressed: () {
                  if (_savedBoard != null) {
                    for (int i = 0; i < _board.length; i++) {
                      _board[i].text = _savedBoard![i];
                    }
                  }
                }),
            ElevatedButton(
                child: const Text('Clear'),
                onPressed: () {
                  for (final controller in _board) {
                    controller.clear();
                  }
                }),
          ],
        ),
      ],
    ));
  }
}

class SudokuTile extends StatelessWidget {
  const SudokuTile({super.key, required this.index, required this.controllers});

  final int index;
  final List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(9, (index) {
        return Container(
          color: Colors.white,
          child: Center(
            child: TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              controller: controllers[this.index ~/ 3 * 27 +
                  this.index % 3 * 3 +
                  index ~/ 3 * 9 +
                  index % 3],
            ),
          ),
        );
      }),
    );
  }
}
