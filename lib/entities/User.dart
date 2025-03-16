import 'dart:math';

import '../util/Password.dart';

class User {

  // attributes
  String? _username;
  String? _password;
  String? _id;

  List<Password> passwords = [];

  // constructor
  User(this._username, this._password) {
    this._id = User.generateRandomID();
  }

  // getters and setters
  String get id => _id!;

  set id(String value) {
    _id = value;
  }

  String get password => _password!;

  set password(String value) {
    _password = value;
  }

  String get username => _username!;

  set username(String value) {
    _username = value;
  }

  void printPasswords() {
    if (passwords.isEmpty) {
      print('No passwords for user $username were found\n');
      return;
    }

    for (int i = 1; i <= passwords.length; i++) {
      print('$i. ${passwords[i - 1]}');
    }
  }

  // adds a new password to the user password list if that password does not exist already
  void addNewPassword(Password password) {
    if (!passwords.contains(password)) {
      passwords.add(password);
    } else {
      // this is just a joke
      print('That password is already assigned to user $username');
    }
  }

  bool removePassword(int index) {
    try {
      passwords.removeAt(index);
      return true;
    } catch (e) {
      print('Error: $e\n');
      return false;
    }
  }

  // return an User if the user exists, otherwise returns null
  static User? checkIfUserExists(String username, List<User> users) {

    for (User user in users) {
      if (username.trim() == user.username) {

        // user exists
        return user;
      }
    }

    // user does not exist
    return null;
  }

  // generate a random id to be used
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

  static Password? checkIfPasswordExists(Password targetPassword, List<Password> passwords) {
    for (Password password in passwords) {
      if (password.password == targetPassword.password) {
        return password;
      }
    }

    return null;
  }

  @override
  String toString() {
    return 'Username: $username, ID: $id';
  }
}