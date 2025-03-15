import 'dart:io';

// static class for input handling
class Input {

  // returns a string handling the user input
  static String getStringInput() {
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


}