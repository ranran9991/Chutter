import 'dart:io';
import 'dart:convert';
import 'dart:collection';

enum RequestType {
  loginRequest,
  exitRequest,
  writeMessageRequest,
  invalidLoginRequest,
  signupRequest,
  invalidSignupRequest
}

abstract class Request {
  RequestType requestType;
  List<String> args;

  String toJSON(){

    Map<String, String> jsonMap = new Map<String, String>();
    jsonMap["request_type"] = requestType.index.toString();

    if(args != null){
      jsonMap["args"] = jsonEncode(args);
    }

    return jsonEncode(jsonMap);
  }

  static Request fromJSON(String jsonText){
    var jsonMap = jsonDecode(jsonText);
    Request request;

    switch(RequestType.values[int.parse(jsonMap["request_type"])]){
      case RequestType.loginRequest:
        var args = jsonDecode(jsonMap["args"]) as List;
        request = new LoginRequest(args[0], args[1]);
        break;
      case RequestType.exitRequest:
        var args = jsonDecode(jsonMap["args"]) as List;
        request = new ExitRequest(args[0]);
        break;
      case RequestType.writeMessageRequest:
        var args = jsonDecode(jsonMap["args"]) as List;
        request = new WriteMessageRequest(args[0], args[1]);
        break;
      case RequestType.invalidLoginRequest:
        request = new InvalidLoginRequest();
        break;
      case RequestType.signupRequest:
        var args = jsonDecode(jsonMap["args"]) as List;
        request = new SignupRequest(args[0], args[1]);
        break;
      case RequestType.invalidSignupRequest:
        request = new InvalidSignupRequest();
        break;
    }
    return request;
  }
}

class LoginRequest extends Request {
  LoginRequest(String name, String password){
    this.args = new List<String>.from([name, password]);
    this.requestType = RequestType.loginRequest;
  }
}

class ExitRequest extends Request {
  ExitRequest(String name){
    this.args = new List<String>.from([name]);
    this.requestType = RequestType.exitRequest;
  }
}

class WriteMessageRequest extends Request {
  WriteMessageRequest(String name, String message){
    this.args = new List<String>.from([name, message]);
    this.requestType = RequestType.writeMessageRequest;
  }
}

class InvalidLoginRequest extends Request {
  InvalidLoginRequest(){
    this.args = null;
    this.requestType = RequestType.invalidLoginRequest;
  }
}

class SignupRequest extends Request {
  SignupRequest(String name, String password){
    this.args = new List<String>.from([name, password]);
    this.requestType = RequestType.signupRequest;
  }
}
class InvalidSignupRequest extends Request {
  InvalidSignupRequest(){
    this.args = null;
    this.requestType = RequestType.invalidSignupRequest;
  }
}