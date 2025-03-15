import 'dart:io';
import '../entities/User.dart';
import '../util/AccountUtils.dart';
import '../util/Input.dart';
import '../util/Password.dart';

// variables to keep track of users in the list and the logged user
List<User> users = [];
User? loggedUser;

// main function
void main() {
  bool exit = false;
  User testUser = User('test123', 'test123');
  users.add(testUser);
  loggedUser = testUser;

  testUser.addNewPassword(Password('test123'));

  // main loop
  do {

    // user is logged in
    if (loggedUser != null) {
      stdout.write(
          '---- SELECT AN OPTION ----\n'
              '[0] Log off\n'
              '[1] Add a new password\n'
              '[2] Show all passwords\n'
              '[3] Search password by tag\n'
              '[4] Add tag to a password\n'
              '[5] Remove a password\n'
              '-> '
      );

      String input = Input.getStringInput();

      switch (input) {
        case '0':
          loggedUser = null;
          print('');

          break;
        case '1':
          stdout.write('=-=-=-=-=- ADD NEW PASSWORD =-=-=-=-=-\nEnter password: ');
          String newPassword = Input.getStringInput();

          if (!Password.validatePassword(newPassword)) {
            break;
          }

          Password password = Password(newPassword);

          // means that the password already exists
          if (User.checkIfPasswordExists(password, loggedUser!.passwords) != null) {
            print('That password already exists\n');
            break;
          }

          loggedUser?.addNewPassword(password);

          stdout.write('Do you want to add tags for the password $newPassword? [Y/N]: ');
          String input = Input.getStringInput().toLowerCase();

          // add tags to the password
          if (input == 'y') {
            while (true) {
              // stdout.write('Enter a tag (empty space to exit): ');
              String? tag = Input.getTagInput();

              if (tag == ' ' || tag == null) {
                break;
              } else {
                password.addTag(tag);
              }

            }
          }

          print('\nPassword added successfully!\n');

          break;
        case '2':

          print('=-=-=-=-=- SHOWING ALL PASSWORDS =-=-=-=-=-:\n');
          if (loggedUser!.passwords.length == 0) {
            print('No passwords found for user $loggedUser');
            break;
          }

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
        case '4':

          print('=-=-=-=-=- ADD TAGS =-=-=-=-=-');
          if (loggedUser!.passwords == null) {
            print('You don''t have any passwords stored!');
            break;
          }

          // prints all passwords
          int passwords = loggedUser!.passwords.length;
          for (int i = 0; i < passwords; i++) {
            print('${i + 1}. ${loggedUser!.passwords[i].toString()}');
          }

          stdout.write('Select a password do add a tag [1 - $passwords]: ');
          int input = Input.getIntInput();
          Password? password = null;

          try {
            password = loggedUser!.passwords[input - 1];
          } catch (e) {
            print('error: $e');
            break;
          }

          // if ((input <= 0) || (input > loggedUser!.passwords.length)) {
          //   print('Invalid password');
          //   break;
          // }

          if (!loggedUser!.passwords.contains(password)) {
            print('invalid password');
          }

          try {
            String pass = password.password;
            print('Password selected: $pass');
          } catch (e) {
            print('error: $e');
          }

          while (true) {
            // stdout.write('Enter a tag (empty space to exit): ');
            String? tag = Input.getTagInput();

            if (tag == ' ' || tag == null) {
              break;
            } else {
              password.addTag(tag);
            }
          }

          break;

        case '5':

          if (loggedUser!.passwords.isEmpty) {
            print('No passwords for user $loggedUser were found');
            break;
          }

          print('=-=--=-=- REMOVE PASSWORD =-=-=-=-=-');

          loggedUser!.printPasswords();
          stdout.write('Select password to remove [1 - ${loggedUser!.passwords.length}]: ');
          int input = Input.getIntInput();

          if (loggedUser!.removePassword(input - 1)) {
            print('Password removed successfully\n');
            break;
          }

          print('Password could not be removed\n');

          break;
        default:

          print('Invalid option\n');
          break;
      }

      // user is not logged in
    } else {
      stdout.write(
          '-- SELECT AN OPTION --:\n'
              '[0] Exit\n'
              '[1] Login\n'
              '[2] Sign in\n'
              '-> '
      );

      String input = Input.getStringInput();

      switch (input) {
        case '0':
          exit = true;
          break;
        case '1':
          stdout.write('=-=-=-=-=- LOGIN =-=-=-=-=-\nUser: ');
          String username = Input.getStringInput();
          User? user = User.checkIfUserExists(username, users);

          if (user == null) {
            print('The user $username does not exist\n');
            break;
          }

          stdout.write('Password for user $username: ');
          String password = Input.getStringInput();

          user = AccountUtils.tryLogin(username, password, users);

          if (user != null) {
            loggedUser = user;
          }

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

          User? accountCreated = AccountUtils.createAccount(username, password, users);

          if (accountCreated == null) {
            break;
          }

          user = User(username, password);
          stdout.write('Account with username $username created successfully! Do you want to login? [Y/N]: ');
          String opc = Input.getStringInput().toLowerCase();

          if (opc == 'y') {
            loggedUser = user;

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