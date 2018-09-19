import 'dart:io';
import 'dart:collection';

import 'package:password/password.dart';

abstract class LoginManager {
  void addUser(String userName, String password);
  void removeUser(String userName, String password);
  bool isUserInDatabase(String username, String password);
}

/*
  this class is login manager that stores logins in memory
  this should be swapped out for SQL database later
*/
class ListLoginManager implements LoginManager {
  static final ListLoginManager _databaseManager = new ListLoginManager._internal();
  HashMap<String, String> _database;
  factory ListLoginManager(){
    
    return _databaseManager;
  }

  ListLoginManager._internal(){
    _database = new HashMap<String, String>();
  }

  void addUser(String userName, String password){
    this._database.putIfAbsent(userName, () => Password.hash(password, new PBKDF2()));
  }

  bool isUserInDatabase(String username, String password){
    if(_database.containsKey(username)){
      return Password.verify(password, _database[username]);
    } 
    return false;   
  }

  void removeUser(String username, String password){
    if(_database.containsKey(username)){
      _database.remove(username);
    }
  }
}