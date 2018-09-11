import 'dart:io';
import 'dart:convert';
import 'dart:async';

class Server{
  int _port;
  String _ip;

  /// Assumes configPath with the IP in the first line and the port in the second line
  Server(String configPath){
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