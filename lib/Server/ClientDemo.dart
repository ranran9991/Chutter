import 'dart:io';

void main(){
  Socket.connect("127.0.0.1", 8657).then((socket) {
    socket.write("Hello, World!");
    return;
  });
}