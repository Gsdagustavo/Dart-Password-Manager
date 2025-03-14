import 'dart:io';
import '../entities/User.dart';
import '../util/Input.dart';
import '../util/Password.dart';
import '../util/input.dart';

List<User> users = [];
User? loggedUser;
bool isLoggedIn = false;

void main() {
  bool exit = false;

  // for testing purposes
  // User test = User('test123', 'test123');
  // users.add(test);
  // loggedUser = test;
  // isLoggedIn = true;

  do {

    if (isLoggedIn) {
        // TODO: Add password management system
      stdout.write(
          '---- SELECT AN OPTION ----\n'
              '[0] Log off\n'
              '[1] Add a new password\n'
              '[2] Show all passwords\n'
              '[3] Search password by tag\n'
              '[4] Remove a password\n'
              '-> '
      );

      String input = Input.getStringInput();

      switch (input) {
        case '0':
          loggedUser = null;
          isLoggedIn = false;

          break;
        case '1':
          stdout.write('=-=-=-=-=- ADD NEW PASSWORD =-=-=-=-=-\nEnter password: ');
          String newPassword = Input.getStringInput();

          if (!Password.validatePassword(newPassword)) {
            break;
          }

          Password password = Password(newPassword);
          loggedUser?.addNewPassword(password);

          stdout.write('Do you want to add tags for the password $newPassword? [Y/N]: ');
          String input = Input.getStringInput().toLowerCase();

          if (input == 'y') {
            String tag = '';
            do {

              stdout.write('Enter a tag (empty space to exit): ');
              tag = Input.getStringInput();

              if (!(tag == ' ')) {
                password.addTag(tag);
              }

            } while (tag != ' ');
          }

          print('\nPassword added successfully!\n');

          break;
        case '2':

          print('=-=-=-=-=- SHOWING ALL PASSWORDS =-=-=-=-=-:\n');

          List<Password>? passwords = loggedUser?.passwords;
          if (passwords != null) {
            for (Password password in passwords) {
              print(password);
            }
          }
          print('');

          break;
        case '3':

          stdout.write('=-=-=-=-=- SEARCH BY TAG =-=-=-=-=-\nEnter tag to search: ');
          String tag = Input.getStringInput();

          List<Password> passwordSearched = Password.findByTag(tag, loggedUser?.passwords);
        
          if (passwordSearched.length > 0) {
            print('\nFound passwords: ');
            passwordSearched.forEach(print);
          } else {
            print('\nNo passwords with tag $tag were found');
          }

          // breaks a new line
          print('');

          break;
        default:

          print('Invalid option\n');
          break;
      }

    } else {
      stdout.write(
          '-- SELECT AN OPTION --:\n'
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
          stdout.write('=-=-=-=-=- LOGIN =-=-=-=-=-\nUser: ');
          String username = getStringInput();
          User? user = User.checkIfUserExists(username, users);

          if (user == null) {
            print('The user $username does not exist\n');
            break;
          }

          stdout.write('Password for user $username: ');
          String password = Input.getStringInput();

          tryLogin(username, password);
          break;
        case '2':
          stdout.write('=-=-=-=-=- SIGN IN =-=-=-=-=-\nUsername: ');
          String username = Input.getStringInput();

          User? user = User.checkIfUserExists(username, users);

          if (user != null) {
            print('That username was already taken\n');
            break;
          }

          stdout.write('Password for user $username: ');
          String password = Input.getStringInput();

          bool accountCreated = createAccount(username, password);

          if (!accountCreated) {
            break;
          }

          user = User(username, password);
          stdout.write('Account with username $username created successfully! Do you want to login? [Y/N]: ');
          String opc = Input.getStringInput().toLowerCase();

          if (opc == 'y') {
            loggedUser = user;
            isLoggedIn = true;

            print('Logged in successfully\n');
          } else if (opc == 'n') {
            print('');
          } else {
            print('Invalid option\n');
          }

          break;
        default:
          print('Invalid option\n');
      }
    }

  } while (!exit);

  print('\nThank you for using my program!\n');
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
    // print('Account with username $username created');
    return true;

  } else {
    print('Account already exists');
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
      String uName = user.username;
      print('\nLogged in successfully as $uName!\n');
      return true;
    } else {

      // password incorrect for the user
      print('Invalid password for user $username');
      return false;
    }
  } else {

    // user does not exist
    print('User $username does not exist');
    return false;
  }
}