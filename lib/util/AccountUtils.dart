import '../entities/User.dart';
import 'Password.dart';

class AccountUtils {

  AccountUtils();

  // function to create an account based on some basic user inputs
  static User? createAccount(String username, String password, List<User> users) {
    User? checkUser = User.checkIfUserExists(username, users);

    // password is invalid
    if (!Password.validatePassword(password)) {
      return null;
    }

    if (checkUser == null) {

      User user = new User(username, password);
      users.add(user);
      // print('Account with username $username created');
      return user;

    } else {
      print('Account already exists');
      return null;
    }
  }

  // returns a user if the login is successful, otherwise returns null
  static User? tryLogin(String username, String password, List<User> users) {
    User? user = User.checkIfUserExists(username, users);

    // check if the user exists
    if (user != null) {

      // check if user password is the same as the entered password
      if (password == user.password) {

        // logged in
        String uName = user.username;
        print('\nLogged in successfully as $uName!\n');
        return user;
      } else {

        // password incorrect for the user
        print('Invalid password for user $username');
        return null;
      }
    } else {

      // user does not exist
      print('User $username does not exist');
      return null;
    }
  }
}