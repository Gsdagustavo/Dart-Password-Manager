import 'dart:math';

class Password {

  // attributes
  String? _password;
  List<String> _tags = [];

  // constructor
  Password(this._password);

  // getters and setters
  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  List<String> get tags => _tags;

  // function that adds a tag to the tags list
  void addTag(String tag) {

    if (!tag.isEmpty) {
      if (!tags.contains(tag)) {
        tags.add(tag);
        print('Tag added successfully!');
      } else {
        print('tag $tag already exists on the list');
      }
    } else {
      print('invalid tag');
    }
  }

  // validate a given string input following some requirements
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

  // returns a list of passwords that contains the tag given
  static List<Password> findByTag(String tagSearched, List<Password>? passwords) {
    if (passwords == null) {
      throw new Exception('Invalid password list');
    }

    List<Password> resultPasswords = [];

    for (Password password in passwords) {
      for (String tag in password.tags) {
        if (tagSearched == tag) {
          resultPasswords.add(password);
        }
      }
    }

    return resultPasswords;
  }

  @override
  String toString() {
    return 'Password: $password, Tags: $tags';
  }
}