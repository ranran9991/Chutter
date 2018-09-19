import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:collection';

import 'package:password/password.dart';

class Server{
  int _port;
  String _ip;
  HashMap<String, Socket> _connected;
    
  /// Assumes configPath with the IP in the first line and the port in the second line
  Server(String configPath){

    this._connected = new HashMap<String, Socket>();

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
        String result = new String.fromCharCodes(data);
        print(result);
        sock.write(result);
    });
  }
}