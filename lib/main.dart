import 'dart:io';
import 'dart:math';
import 'dart:math' as math;

class Password {
  String? _password;
  int? _id;
  List<String>? _tags;

  Password(this._password, this._id);

  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  List<String> get tags => _tags!;

  void addTag(String tag) {
    if (tag.isNotEmpty) {
      tags.add(tag);
    }
  }
}

void main() {

}

String getStringInput() {
  String? input = stdin.readLineSync();

  while (input == null || input.isEmpty) {
    stdout.write('invalid input, try again: ');
    input = stdin.readLineSync();
  }

  return input;
}

void printList(list) {
  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }
}