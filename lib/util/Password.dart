import 'dart:math';

class Password {

  // attributes
  String? _password;
  int? _id;
  List<String>? _tags;

  // constructor
  Password(this._password, this._id);

  // getters and setters
  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  List<String> get tags => _tags!;

  // function that adds a tag to the tags list
  void addTag(String tag) {

    if (tag.isNotEmpty) {
      if (!tags.contains(tag)) {
        tags.add(tag);
      } else {
        print('tag $tag already exists on the list');
      }
    } else {
      print('invalid tag');
    }
  }

  static String generateRandomID() {
    const int characters = 15;
    String possibleCharacters =
        "ABCDEFGHIKJLMNOPQRSTUVWXYZ"
        "abcdefghijklmnopqrstuvwxyz"
        "1234567890"
        "!@#%^&*";

    Random random = Random();
    String id = '';
    for (int i = 0; i < characters; i++) {
      id += possibleCharacters[random.nextInt(possibleCharacters.length)];
    }

    return id;
  }

  static bool validatePassword(String password) {
    const int minLength = 6;
    const int maxLength = 15;

    if (password.isEmpty) {
      print('the password cannot be empty');
      return false;
    }

    if (password.length > 0 && password.length < minLength) {
      print('the password is too short');
      return false;
    }

    if (password.length > maxLength) {
      print('the password is too big');
      return false;
    }

    return true;
  }
}