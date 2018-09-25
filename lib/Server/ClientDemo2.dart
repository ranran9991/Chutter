import 'dart:io';
import '../Infrastructure/Request.dart';
import 'dart:async';

void main() async {
  Socket socket = await Socket.connect("127.0.0.1", 8657);
  socket.listen((List<int> data){
    print(String.fromCharCodes(data));
  });
  
  SignupRequest request = new SignupRequest("shay", "123456");
  socket.write(request.toJSON());
  
  LoginRequest loginRequest = new LoginRequest("shay", "123456");
  socket.write(loginRequest.toJSON());
  
  sleep(new Duration(seconds: 3));
  WriteMessageRequest writeMessageRequest = new WriteMessageRequest("shay", "Hey ran!");
  socket.write(writeMessageRequest.toJSON());
}