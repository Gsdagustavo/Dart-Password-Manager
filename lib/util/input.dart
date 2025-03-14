import 'dart:io';

String getStringInput() {
  String? input = stdin.readLineSync() ?? '';

  while (input == null) {
    stdout.write('Invalid input, try again: ');
    input = stdin.readLineSync() ?? '';
  }

  while (input!.isEmpty) {
    stdout.write('Invalid input, try again: ');
    input = stdin.readLineSync() ?? '';
  }

  return input;
}