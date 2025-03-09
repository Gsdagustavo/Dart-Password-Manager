import 'dart:io';
import 'dart:math';
import 'User.dart';
import 'Password.dart';

List<User> users = [];
User? loggedUser;
bool isLoggedIn = false;

void main() {

  // TESTING

  // createAccount('hello123', 'helloworld');
  // createAccount('1', '1');
  //
  // tryLogin('hello123', 'helloworld');
  // tryLogin('hello123', '12');
  //
  // User? u = checkIfUserExists('hello123');

  bool exit = false;

  do {

    if (isLoggedIn) {
        // TODO: Add password management system
    } else {
      stdout.write(
          'select an option:\n'
              '[0] Exit\n'
              '[1] Login\n-> '
      );

      String input = getStringInput();

      // TODO: Add proper functionalities
      switch (input) {
        case '0':
          exit = true;
          break;
        case '1':
          print('login');
          break;
        default:
          print('invalid option');
      }
    }

  } while (!exit);
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

String generateRandomID() {
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

bool validatePassword(String password) {
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

bool createAccount(String username, String password) {
  User? checkUser = checkIfUserExists(username);

  // password is invalid
  if (!validatePassword(password)) {
    return false;
  }

  if (checkUser == null) {

    String id = generateRandomID();
    User user = new User(username, password, id);
    users.add(user);
    print('account with username $username created');
    return true;

  } else {
    print('account already exists');
    return false;
  }
}

bool tryLogin(String username, String password) {
  User? user = checkIfUserExists(username);

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

// return an User if the user exists, otherwise returns null
User? checkIfUserExists(String username) {

  for (User user in users) {
    if (username == user.username) {

      // user exists
      return user;
    }
  }

  // user does not exist
  return null;
}

// prints a list
void printList(list) {
  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }
}