import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:collection';

import 'LoginManager.dart';
import '../Infrastructure/Request.dart';
import 'ChatMessage.dart';


class Server{
  int _port;
  String _ip;
  LoginManager loginManager;
  List<Socket> _connected;
    
  /// Assumes configPath with the IP in the first line and the port in the second line
  Server(String configPath){
    this._connected = new List<Socket>();
    loginManager = ListLoginManager();
    // get ip and port from config file
    var f = new File(configPath);
    var content = f.readAsStringSync().split("\n");
    _ip = content[0].trim();
    print(_ip);
    _port = int.parse(content[1].trim());
    print(_port);
  }

  void Start(){
    ServerSocket.bind(_ip, _port)
      .then((serverSocket) {
        serverSocket.listen((socket) {
          handleClient(socket);
        });
      });
  }  

  void handleClient(Socket sock){
    sock.listen((List<int> data) {
        String input = new String.fromCharCodes(data);
        // handle request
        try{
          Request request = Request.fromJSON(input);
          switch(request.requestType){
            // login request
            case RequestType.loginRequest:
              String username = request.args[0];
              String password = request.args[1];
              // if user not in database
              if(!this.loginManager.isUserInDatabase(username, password)){
                InvalidLoginRequest invalidLoginRequest = new InvalidLoginRequest();
                sock.write(invalidLoginRequest.toJSON());
                return;
              }
              else{
                sock.write(request.toJSON());
                _connected.add(sock);
              }
              break;
            // exit request
            case RequestType.exitRequest:
              // remove this socket from connected list
              this._connected.remove(sock);
              break;
            // pass message request
            case RequestType.writeMessageRequest:
              // reroute message for all connected users
              for (Socket connectedSocket in this._connected){
                connectedSocket.write(request.toJSON());
              }
              break;
            // do nothing
            case RequestType.signupRequest:

              String username = request.args[0];
              String password = request.args[1];

              // if user is not in database
              if(!this.loginManager.isUserInDatabase(username, password)){
                loginManager.addUser(username, password);
                // return the same request to the user
                 sock.write(request.toJSON());
              }
              // credentials already taken
              else{
                InvalidSignupRequest invalidSignupRequest = new InvalidSignupRequest();
                
                sock.write(invalidSignupRequest.toJSON());

              }
              break;
            
            default:
              break;
          }
        }
        catch(e){
          print("Error occoured: " + e.toString());
        }
    });
  }
}