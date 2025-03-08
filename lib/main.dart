import 'dart:io';

void main() {
  stdout.write('enter your first name: ');
  String firstName = getStringInput();

  stdout.write('enter your second name: ');
  String secondName = getStringInput();

  String name = firstName + ' ' + secondName;
  print('your name is $name');
}

String getStringInput() {
  String? input = stdin.readLineSync();

  while (input == null || input.isEmpty) {
    stdout.write('invalid input, try again: ');
    input = stdin.readLineSync();
  }

  return input;
}