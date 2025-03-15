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

  static int getIntInput() {

    while (true) {
      String stringInput = getStringInput();
      int? intInput = int.tryParse(stringInput);

      if (intInput != null) {
        return intInput;
      }

      stdout.write('Invalid input. Please enter an integer: ');
    }
  }

  static String? getTagInput() {

    String tag = '';
    stdout.write('Enter a tag (empty space to exit): ');
    tag = Input.getStringInput();

    if (tag.isNotEmpty) {
      return tag;
    } else {
      return null;
    }
  }
}