import 'package:flutter/material.dart';

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

  void _updateBoard(int index, int value) {
    setState(() {
      _board[index].text = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: List.generate(9, (index) {
            return SudokuTile(index: index, controllers: _board);
          }),
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
              controller: controllers[this.index * 9 + index],
            ),
          ),
        );
      }),
    );
  }
}
