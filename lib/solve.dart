import 'package:flutter/material.dart';

Set _numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9};

// Rule 1: If a row is missing a number, fill it in.
void solve1(List<TextEditingController> board) {
  for (int row = 0; row < 9; row++) {
    final Set numbers = Set.from(_numbers);
    int emptyIndex = -1;
    for (int col = 0; col < 9; col++) {
      final int index = row * 9 + col;
      final String text = board[index].text;
      if (text.isNotEmpty) {
        numbers.remove(int.parse(text));
      } else {
        emptyIndex = index;
      }
    }
    if (numbers.length != 1 || emptyIndex == -1) {
      continue;
    }
    board[emptyIndex].text = numbers.first.toString();
  }
}

// Rule 2: If a column is missing a number, fill it in.
void solve2(List<TextEditingController> board) {
  for (int col = 0; col < 9; col++) {
    final Set numbers = Set.from(_numbers);
    int emptyIndex = -1;
    for (int row = 0; row < 9; row++) {
      final int index = row * 9 + col;
      final String text = board[index].text;
      if (text.isNotEmpty) {
        numbers.remove(int.parse(text));
      } else {
        emptyIndex = index;
      }
    }
    if (numbers.length != 1 || emptyIndex == -1) {
      continue;
    }
    board[emptyIndex].text = numbers.first.toString();
  }
}

// Rule 3: If a box is missing a number, fill it in.
void solve3(List<TextEditingController> board) {
  for (int boxRow = 0; boxRow < 3; boxRow++) {
    for (int boxCol = 0; boxCol < 3; boxCol++) {
      final Set numbers = Set.from(_numbers);
      int emptyIndex = -1;
      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          final int index = (boxRow * 3 + row) * 9 + (boxCol * 3 + col);
          final String text = board[index].text;
          if (text.isNotEmpty) {
            numbers.remove(int.parse(text));
          } else {
            emptyIndex = index;
          }
        }
      }
      if (numbers.length != 1 || emptyIndex == -1) {
        continue;
      }
      board[emptyIndex].text = numbers.first.toString();
    }
  }
}

// Rule 4: If a number is missing from a row, column, or box, fill it in.
void solve4(List<TextEditingController> board) {
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      final int index = row * 9 + col;
      final String text = board[index].text;
      if (text.isNotEmpty) {
        continue;
      }
      final Set numbers = Set.from(_numbers);
      for (int i = 0; i < 9; i++) {
        final int index2 = row * 9 + i;
        final String text2 = board[index2].text;
        if (text2.isNotEmpty) {
          numbers.remove(int.parse(text2));
        }
      }
      for (int i = 0; i < 9; i++) {
        final int index2 = i * 9 + col;
        final String text2 = board[index2].text;
        if (text2.isNotEmpty) {
          numbers.remove(int.parse(text2));
        }
      }
      final int boxRow = row ~/ 3;
      final int boxCol = col ~/ 3;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          final int index2 = (boxRow * 3 + i) * 9 + (boxCol * 3 + j);
          final String text2 = board[index2].text;
          if (text2.isNotEmpty) {
            numbers.remove(int.parse(text2));
          }
        }
      }
      if (numbers.length != 1) {
        continue;
      }
      board[index].text = numbers.first.toString();
    }
  }
}

// Rule 5: Recursion
// Recursive helper function
void solve5(List<TextEditingController> board) {
  final List<int> emptyIndices = [];
  for (int index = 0; index < 81; index++) {
    final String text = board[index].text;
    if (text.isEmpty) {
      emptyIndices.add(index);
    }
  }
  // Call the recursive function with the indices of the empty cells, with index at the first empty cell.
  _solve5(board, emptyIndices, 0);
}

// Recursive function
bool _solve5(List<TextEditingController> board, List<int> emptyIndices, int index) {
  // Base case: If we've filled in all the empty cells, we're done.
  if (index == emptyIndices.length) {
    return true;
  }
  // Recursive case: Try each number in the current cell.
  // emptyIndex is the index of the index-th empty cell.
  final int emptyIndex = emptyIndices[index];
  // row and col are the row and column of the index-th empty cell.
  final int row = emptyIndex ~/ 9;
  final int col = emptyIndex % 9;
  // boxRow and boxCol are the row and column of the box containing the index-th empty cell.
  final int boxRow = row ~/ 3;
  final int boxCol = col ~/ 3;
  // numbers is the set of numbers that are not in the same row, column, or box as the index-th empty cell.
  final Set numbers = Set.from(_numbers);
  // Remove the numbers that are in the same row as the index-th empty cell.
  for (int i = 0; i < 9; i++) {
    final int index2 = row * 9 + i;
    final String text2 = board[index2].text;
    if (text2.isNotEmpty) {
      numbers.remove(int.parse(text2));
    }
  }
  // Remove the numbers that are in the same column as the index-th empty cell.
  for (int i = 0; i < 9; i++) {
    final int index2 = i * 9 + col;
    final String text2 = board[index2].text;
    if (text2.isNotEmpty) {
      numbers.remove(int.parse(text2));
    }
  }
  // Remove the numbers that are in the same box as the index-th empty cell.
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      final int index2 = (boxRow * 3 + i) * 9 + (boxCol * 3 + j);
      final String text2 = board[index2].text;
      if (text2.isNotEmpty) {
        numbers.remove(int.parse(text2));
      }
    }
  }
  // Try each number in the current cell.
  for (final int number in numbers) {
    // Set the current cell to the current number.
    board[emptyIndex].text = number.toString();
    // Recursively call the function with the next empty cell.
    if (_solve5(board, emptyIndices, index + 1)) {
      // Successful, so return true.
      return true;
    }
  }
  // Unsuccessful, so reset the current cell and return false.
  board[emptyIndex].text = '';
  return false;
}