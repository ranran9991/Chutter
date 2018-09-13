import 'dart:io';
import 'dart:convert';

enum RequestType {
  loginRequest,
  exitRequest
}

abstract class Request {
  RequestType requestType;
  List<String> args;

  String toJSON(){
    var jsonMap = {
      "request_type" : requestType.index.toString(),
      "args" : jsonEncode(args)
    };

    String jsonText = jsonEncode(jsonMap);

    return jsonText;
  }

  static Request fromJSON(String jsonText){
    var jsonMap = jsonDecode(jsonText);
    var args = jsonDecode(jsonMap["args"]) as List;
    Request request;

    switch(RequestType.values[int.parse(jsonMap["request_type"])]){
      case RequestType.loginRequest:
        request = new LoginRequest(args[0], args[1]);
        break;
      case RequestType.exitRequest:
        request = new ExitRequest(args[0]);
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