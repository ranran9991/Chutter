import 'dart:io';
import '../Infrastructure/Request.dart';

void main() async {
  Socket socket = await Socket.connect("127.0.0.1", 8657);
  socket.listen((List<int> data){
    print(String.fromCharCodes(data));
  });
  
  SignupRequest request = new SignupRequest("ran", "123456");
  socket.write(request.toJSON());
  
  LoginRequest loginRequest = new LoginRequest("ran", "123456");
  socket.write(loginRequest.toJSON());
  
  sleep(new Duration(seconds: 2));
  WriteMessageRequest writeMessageRequest = new WriteMessageRequest("ran", "Hey dumbass!");
  socket.write(writeMessageRequest.toJSON());
}