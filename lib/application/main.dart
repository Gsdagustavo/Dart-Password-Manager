import 'dart:io';
import '../entities/User.dart';
import '../util/Password.dart';

List<User> users = [];
User? loggedUser;
bool isLoggedIn = false;

void main() {
  bool exit = false;

  User test = User('test123', 'test123');
  users.add(test);

  do {

    if (isLoggedIn) {
        // TODO: Add password management system

    } else {
      stdout.write(
          'select an option:\n'
              '[0] Exit\n'
              '[1] Login\n'
              '[2] Sign in\n'
              '-> '
      );

      String input = getStringInput();

      // TODO: Add proper functionalities
      switch (input) {
        case '0':
          exit = true;
          break;
        case '1':
          stdout.write('=-=-=-=-=- LOGIN =-=-=-=-=-\nuser: ');
          String username = getStringInput();
          User? user = User.checkIfUserExists(username, users);

          if (user == null) {
            print('the user $username does not exist');
            break;
          }

          stdout.write('password for user $username: ');
          String password = getStringInput();

          tryLogin(username, password);
          break;
        case '2':
          stdout.write('=-=-=-=-=- SIGN IN =-=-=-=-=-\nusername: ');
          String username = getStringInput();

          User? user = User.checkIfUserExists(username, users);

          if (user != null) {
            print('that username is already taken');
            break;
          }

          stdout.write('password for user $username: ');
          String password = getStringInput();

          createAccount(username, password);
          stdout.write('account with username $username created successfully! do you want to login? [Y/N]: ');
          String opc = getStringInput().toLowerCase();

          user = User(username, password);

          switch (opc) {
            case 'y':
              loggedUser = user;
              isLoggedIn = true;
              print('logged in successfully');
              break;
            case 'n':
              break;
            default:
              print('invalid option');
              break;
          }

          break;
        default:
          print('invalid option');
      }
    }

  } while (!exit);

  print('thank you for using my program!');
}

String getStringInput() {
  String? input = stdin.readLineSync() ?? '';

  while (input == null) {
    stdout.write('invalid input, try again: ');
    input = stdin.readLineSync() ?? '';
  }

  while (input!.isEmpty) {
    stdout.write('invalid input, try again: ');
    input = stdin.readLineSync() ?? '';
  }

  return input;
}

bool createAccount(String username, String password) {
  User? checkUser = User.checkIfUserExists(username, users);

  // password is invalid
  if (!Password.validatePassword(password)) {
    return false;
  }

  if (checkUser == null) {

    User user = new User(username, password);
    users.add(user);
    print('account with username $username created');
    return true;

  } else {
    print('account already exists');
    return false;
  }
}

bool tryLogin(String username, String password) {
  User? user = User.checkIfUserExists(username, users);

  // check if the user exists
  if (user != null) {

    // check if user password is the same as the entered password
    if (password == user.password) {

      // logged in
      isLoggedIn = true;
      loggedUser = user;
      print('logged in successfully');
      return true;
    } else {

      // password incorrect for the user
      print('invalid password for user $username');
      return false;
    }
  } else {

    // user does not exist
    print('user $username does not exist');
    return false;
  }
}