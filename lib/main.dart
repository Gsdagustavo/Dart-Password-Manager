import 'dart:io';
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
}

class User {

  // attributes
  String? _username;
  String? _password;
  String? _id;

  // constructor
  User(this._username, this._password, this._id);

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
}

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