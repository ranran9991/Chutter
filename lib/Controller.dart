 import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';

import 'Infrastructure/Request.dart';
// singelton client class
class Controller {
  static final Controller _controller = Controller._internal();
  factory Controller(){
    return _controller;
  }
  Controller._internal(){
    _doneFuture = _init();
  }
  Socket socket;
  Stream<List<int>> broadcastSocket;

  Future _doneFuture;
  Future get initializationDone => _doneFuture;
  // send login request to server
  Future<void> sendLoginRequest(String name, String password) async{
    LoginRequest loginRequest = new LoginRequest(name, password);
    await this.initializationDone;
    socket.write(loginRequest.toJSON());
  }
  // send signup request to server
  Future<void> sendSignupRequest(String name, String password) async{
    SignupRequest signupRequest = new SignupRequest(name, password);
    await this.initializationDone;
    socket.write(signupRequest.toJSON());
  }
  // send message request to server
  Future<void> sendMessage(String name, String message) async{
    WriteMessageRequest writeMessageRequest = new WriteMessageRequest(name, message);
    await this.initializationDone;
    socket.write(writeMessageRequest.toJSON());
  }
  // load config file from assets
  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config.json');
  }
  // parse config file for ip and port and connect to server
  Future _init() async {
    String ip;
    int port;
    await loadAsset().then((config){
      print("loading assets");
      // parse config json
      var configJson = jsonDecode(config);
      ip = configJson["ip"];
      port = int.parse(configJson["port"]);
    });
    // connect to server
    print("connecting to server on:");
    print("IP: " + ip);
    print("Port: " + port.toString());
    socket = await Socket.connect(ip, port);
    broadcastSocket = socket.asBroadcastStream();
  }
}