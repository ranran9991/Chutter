
abstract class CredentialsValidator {
  bool isUsernameValid(String username);
  bool isPasswordValid(String password);
}

class NormalCredentialsValidator implements CredentialsValidator {
  bool isUsernameValid(String username){
    // length
    if(username.length > 16 || username.length < 4){
      return false;
    }
    // unallowed charachters
    if(username.contains(' ') ||
      username.contains('_') ||
      username.contains('-') || 
      username.contains('}') ||
      username.contains('{') ||
      username.contains(']') ||
      username.contains('[')){
      return false;
    }

    return true;
  }

  bool isPasswordValid(String password){
    // length
    if(password.length > 16 || password.length < 4){
      return false;
    }
    // unallowed charachters
    if(password.contains(' ') ||
      password.contains('_') ||
      password.contains('-') || 
      password.contains('}') ||
      password.contains('{') ||
      password.contains(']') ||
      password.contains('[')){
      return false;
    }

    return true;
  }
}