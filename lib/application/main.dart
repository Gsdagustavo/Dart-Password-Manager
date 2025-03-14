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
  loggedUser = test;
  isLoggedIn = true;

  do {

    if (isLoggedIn) {
        // TODO: Add password management system
      stdout.write(
          'select an option:\n'
              '[0] Log off\n'
              '[1] Add a new password\n'
              '[2] Show all passwords\n'
              '[3] Search password by tag\n'
              '[4] Remove a password\n'
              '-> '
      );

      String input = getStringInput();

      switch (input) {
        case '0':
          loggedUser = null;
          isLoggedIn = false;

          break;
        case '1':
          stdout.write('=-=-=-=-=- ADD NEW PASSWORD =-=-=-=-=-\nEnter password: ');
          String newPassword = getStringInput();

          if (!Password.validatePassword(newPassword)) {
            break;
          }

          Password password = Password(newPassword);
          loggedUser?.addNewPassword(password);

          stdout.write('do you want to add tags for the password $newPassword? [Y/N]: ');
          String input = getStringInput().toLowerCase();

          if (input == 'y') {
            String tag = '';
            do {

              stdout.write('enter a tag (or enter an empty space to exit): ');
              tag = getStringInput();

              if (!(tag == ' ')) {
                password.addTag(tag);
              }

            } while (tag != ' ');
          }

          print('password added successfully\n');

          break;
        case '2':

          print('showing all passwords:\n');

          List<Password>? passwords = loggedUser?.passwords;
          if (passwords != null) {
            for (Password password in passwords) {
              print(password);
            }
          }

          break;
        default:
          print('invalid option\n');
          break;
      }

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
            print('the user $username does not exist\n');
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
            print('that username is already taken\n');
            break;
          }

          stdout.write('password for user $username: ');
          String password = getStringInput();

          bool accountCreated = createAccount(username, password);

          if (!accountCreated) {
            break;
          }

          stdout.write('account with username $username created successfully! do you want to login? [Y/N]: ');
          String opc = getStringInput().toLowerCase();

          user = User(username, password);

          switch (opc) {
            case 'y':
              loggedUser = user;
              isLoggedIn = true;
              print('logged in successfully\n');
              break;
            case 'n':
              break;
            default:
              print('invalid option\n');
              break;
          }

          break;
        default:
          print('invalid option\n');
      }
    }

  } while (!exit);

  print('thank you for using my program!\n');
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